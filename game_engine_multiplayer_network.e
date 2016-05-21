note
	description: "Engine that manage the game for 2 players using network."
	author: "Alexandre Caron"
	date: "09 May 2016"

class
	GAME_ENGINE_MULTIPLAYER_NETWORK

inherit
	GAME_ENGINE_NON_LOCAL
		redefine
			normal_deplacement,
			kill_deplacement,
			start,
			set_agents,
			quit,
			game_over
		end

create
	make_multiplayer_network

feature{NONE} -- Initialization

	make_multiplayer_network(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY; a_socket: NETWORK_STREAM_SOCKET; a_is_white: BOOLEAN)
				--<Precursor>
			do
				socket := a_socket
				make_multiplayer(a_window, a_factory, a_is_white)
--				if is_player_white then
--					grid.reverse
--				end
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
			game_thread.main_socket.independent_store (grid)
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
			socket.independent_store ("OK")
			if game_thread.grid_received then
				grid := game_thread.grid
				game_thread.set_grid_received (false)
				turn_is_done := false
--				if is_player_white then
--					print("reversing")
--					grid.reverse
--				end
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

	game_over
			-- <Precursor>
		do
			Precursor
			game_thread.stop_thread
			game_thread.main_socket.close
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
