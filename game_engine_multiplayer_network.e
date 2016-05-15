note
	description: "Engine that manage the game for 2 players using network."
	author: "Alexandre Caron"
	date: "09 May 2016"

class
	GAME_ENGINE_MULTIPLAYER_NETWORK

inherit
	GAME_ENGINE_NON_LOCAL
		redefine
			draw_piece,
			normal_deplacement,
			kill_deplacement,
			start,
			set_agents,
			quit
		end

create
	make_multiplayer_network

feature{NONE} -- Initialization

	make_multiplayer_network(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY; a_socket: NETWORK_STREAM_SOCKET; a_is_white: BOOLEAN)
				--<Precursor>
			do
				socket := a_socket
				make_multiplayer(a_window, a_factory, a_is_white)
				create game_thread.make (socket, grid)
			end

feature -- Public Attributs

	socket: NETWORK_STREAM_SOCKET
			-- The `Socket' used to communication with the other player.
	game_thread: GAME_THREAD
			-- The `Thread' that will use the `Socket'.


feature {NONE} -- Private Methods

	other_player_turn
			-- Manage the turn of the other player/AI.
		do
			print("Other player played %N")
			game_thread.main_socket.independent_store (grid)
			print("Grid envoyé %N")
		end

	draw_piece
			-- Draw every pieces contained in the grid.
		local
			l_position: TUPLE[x,y: INTEGER]
			l_reverse_position: TUPLE[line, column:INTEGER]
		do
			if is_player_white then
				across grid.grid as la_line loop
					across la_line.item as la_column loop
						if attached {PIECE} la_column.item as la_piece then
							if attached la_piece.position as la_position then
								l_reverse_position := [8 - la_position.line + 1, la_position.column]
								l_position := convert_grid_to_coord (la_position)
								la_piece.set_positions (l_position.x, l_position.y)
								window.renderer.draw_texture (la_piece.texture, l_position.x, l_position.y)
							end
						end
					end
				end
			else
				Precursor
			end
		end

	normal_deplacement (l_position: TUPLE[line, column :INTEGER])
			-- <Precusor>
		do
			Precursor(l_position)
			if is_white_turn /= is_player_white and not turn_is_done then
				turn_is_done := true
				other_player_turn
			end
		end

	kill_deplacement (l_position: TUPLE[line, column :INTEGER])
			-- <Precusor>
		do
			Precursor(l_position)
			if is_white_turn /= is_player_white and not turn_is_done then
				turn_is_done := true
				other_player_turn
			end
		end

	on_iteration(a_timestamp: NATURAL_32)
			-- At every frames
		do
			if game_thread.grid_received then
				print("Grid received at: " + a_timestamp.out)
				grid := game_thread.grid
				game_thread.set_grid_received (false)
				grid.update (factory)
				toggle_turn
				draw_all
			end
		end

	start
			-- <Precursor>
		do
			must_quit := False
			set_agents
			draw_all
			window.update
			game_thread.launch
			game_library.launch
		end

	set_agents
			-- <Precursor>
		do
			Precursor
			game_library.iteration_actions.extend (agent on_iteration)
		end

	quit(a_timestamp: NATURAL_32)
			-- <Precursor>
		do
			game_thread.stop_thread
			game_thread.main_socket.close
			Precursor (a_timestamp)
		end


note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
