note
	description: "Abstract class for the game_engine."
	author: "Alexandre Caron"
	date: "02 May 2016"

class
	GAME_ENGINE_MULTIPLAYER_LOCAL

inherit
	ENGINES
		redefine
			draw_all
		end
	GRID_UTILS

create
	make

feature{NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY)
		-- Create an `Current'.
		do
			factory := a_factory
			window := a_window
			create grid.make(window.renderer, factory)
			is_white_turn := True
			is_multiplayer := False
			game_is_over := False
			init_ressources
		end

feature -- Attributs

	is_multiplayer: BOOLEAN
			-- If the game is multiplayer (True) or singleplayer (False)
	selected_piece:detachable PIECE
			-- The current `piece' selected
	valid_movements:detachable LIST[TUPLE[line, column:INTEGER]]
			-- List of valid movements for the selected `piece'
	valid_kills:detachable LIST[TUPLE[line, column:INTEGER]]
			-- List of valid kills for the selected `piece'
	grid: GRID
			-- The grid containing every `piece' and there position.
	is_white_turn: BOOLEAN
			-- True when it is white turn, False if black turn.
	game_is_over: BOOLEAN
			-- True if the game is over.
	is_quitting: BOOLEAN
			-- True if the player wants tp quit the game.

feature {NONE} -- Private Methods

	calcul_valid_movement
			-- Calcul the valid position for the `selected_piece'
		local
			l_possible_position: TUPLE[line, column: INTEGER]
			l_range: INTEGER
			l_fictive_line: INTEGER
			l_fictive_column: INTEGER
		do
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_movements.make (28)
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_kills.make (8)
			if attached selected_piece as la_piece then
				if attached la_piece.position as la_position then
					across la_piece.move as la_move loop
						l_fictive_line := la_position.line
						l_fictive_column := la_position.column
						from
							l_range := 0
						until
							l_range = la_move.item.max_range
						loop
							l_possible_position := [l_fictive_line + la_piece.side * la_move.item.line, l_fictive_column + la_piece.side * la_move.item.column]
							if l_possible_position.line > 0 and l_possible_position.line < 9 and l_possible_position.column > 0 and l_possible_position.column < 9 then
								if attached {PIECE} grid.grid.at (l_possible_position.line).at (l_possible_position.column) as la_possible_ennemy then
									if la_possible_ennemy.is_white /= la_piece.is_white then
										if attached valid_kills as la_valid_kills then
											la_valid_kills.extend (l_possible_position)
											l_range := la_move.item.max_range - 1
										end
									end
								else
									if attached valid_movements as la_valid_movements then
										l_fictive_line := l_fictive_line + la_piece.side * la_move.item.line
										l_fictive_column := l_fictive_column + la_piece.side * la_move.item.column
										la_valid_movements.extend (l_possible_position)
									end
								end
							end
							l_range := l_range + 1
						end
					end
				end
			end
		end

	draw_valid_kill(a_valid_kill:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE)
			-- Draw color to show killable piece.
		local
			l_coord:TUPLE[x, y:INTEGER]
		do
			across a_valid_kill as la_valid_kill loop
				l_coord:=convert_grid_to_coord(la_valid_kill.item)
				window.renderer.draw_texture (a_texture, l_coord.x, l_coord.y)
			end
		end

	draw_valid_movement(a_valid_positions:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE)
			-- Draw color to show possible movement.
		local
			l_coord:TUPLE[x, y:INTEGER]
		do
			across a_valid_positions as la_valid_position loop
				l_coord := convert_grid_to_coord(la_valid_position.item)
				window.renderer.draw_texture (a_texture, l_coord.x, l_coord.y)
			end
		end
	mouse_pressed_when_game_over (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Manage the mouse pressed when the game is over.
		do
			across textures as la_texture loop
				if cursor_hover_texture (a_mouse_state, la_texture.item) then
					if attached {BUTTON} la_texture.item as la_button then
						la_button.on_click
					end
				end
			end
		end

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Manage when mouse is pressed.
		local
			l_position:TUPLE[line, column:INTEGER]
		do
			click_sound.play_once
			if game_is_over then
				mouse_pressed_when_game_over (a_timestamp, a_mouse_state, a_nb_clicks)
			else
				l_position := convert_coord_to_grid([a_mouse_state.x, a_mouse_state.y])
				if l_position.line /= 0 and l_position.column /= 0 then
					if selected_piece /= void then -- Piece already selected
						if attached selected_piece as la_selected_piece and attached valid_movements as la_valid_movements and attached valid_kills as la_valid_kills then
							-- Normal Deplacement
							normal_deplacement (l_position)
							-- Kill
							kill_deplacement (l_position)
						end
						unselect
					else -- Selecting a piece
						if attached {PIECE} grid.grid.at(l_position.line).at(l_position.column) as la_piece then
							if (la_piece.is_white and is_white_turn) or (la_piece.is_black and not is_white_turn) then
								selected_piece:=la_piece
								calcul_valid_movement
							end
						else
							unselect
						end
					end
					draw_all -- Redraw no matter what.
				end
			end
		end

	normal_deplacement (a_position:TUPLE[line, column:INTEGER])
			-- When the player do a regular deplacement.
		do
			if attached valid_movements as la_valid_movements and attached selected_piece as la_selected_piece then
				across la_valid_movements as la_movement loop
					if la_movement.item.line = a_position.line and la_movement.item.column = a_position.column then
						if attached la_selected_piece.position as la_position then
							grid.grid.at (la_position.line).at (la_position.column) := void
							grid.grid.at (a_position.line).at (a_position.column) := la_selected_piece
							la_selected_piece.set_grid_position (la_movement.item.line, la_movement.item.column)
							la_selected_piece.first_move_done
							toggle_turn
						end
					end
				end
			end
		end

	kill_deplacement (a_position:TUPLE[line, column:INTEGER])
			-- When a player finish his turn by killing a piece.
		do
			if attached valid_kills as la_valid_kills and attached selected_piece as la_selected_piece then
				across la_valid_kills as la_kill loop
					if la_kill.item.line = a_position.line and la_kill.item.column = a_position.column then
						if attached la_selected_piece.position as la_position then
							grid.grid.at (la_position.line).at (la_position.column) := void
							grid.grid.at (a_position.line).at (a_position.column) := la_selected_piece
							la_selected_piece.set_grid_position (la_kill.item.line, la_kill.item.column)
							toggle_turn
						end
					end
				end
			end
		end

	toggle_turn
			-- Toggle things for the other team turn.
		do
			across textures as la_texture loop
				if la_texture.item.texture = factory.white_turn then
					la_texture.item.texture := factory.black_turn
				elseif la_texture.item.texture = factory.black_turn then
					la_texture.item.texture := factory.white_turn
				end
			end
			is_white_turn := not is_white_turn
			if is_game_over then
				game_is_over := True
				game_over
			end
		end

	game_over
			-- When the game is over.
		local
			l_game_over: BACKGROUND
			l_quit: BUTTON
		do
			create l_game_over.make(factory.game_over)
			create l_quit.make (factory.quit_button, 633, 400, agent quit_game)
			textures.extend (l_game_over)
			textures.extend (l_quit)

		end

	quit_game
			-- When the quit `Button' is clicked.
		do
			game_library.clear_all_events
			window.renderer.clear
			game_library.stop
			is_quitting := True
		end

	is_game_over: BOOLEAN
			-- Verify if the game is over. Return True is so, False otherwise.
		local
			l_white_king_alive: BOOLEAN
			l_black_king_alive: BOOLEAN
		do
			across grid.grid as la_line loop
				across la_line.item as la_column loop
					if attached {KING} la_column.item as la_king then
						if la_king.is_white then
							l_white_king_alive := True
						else
							l_black_king_alive := True
						end
					end
				end
			end
			result := not (l_white_king_alive and l_black_king_alive)
			print(result.out)
		end

	draw_piece
			-- Draw every pieces contained in the grid.
		local
			l_position: TUPLE[x,y: INTEGER]
		do
			across grid.grid as la_line loop
				across la_line.item as la_column loop
					if attached {PIECE} la_column.item as la_piece then
						if attached la_piece.position as la_position then
							l_position := convert_grid_to_coord (la_position)
							la_piece.set_positions (l_position.x, l_position.y)
							window.renderer.draw_texture (la_piece.texture, l_position.x, l_position.y)
						end
					end
				end
			end
		end

	redraw
			--Redraw the `Piece' and there possible movements/kills.
		do
			if attached valid_movements as la_valid_movements then
				draw_valid_movement(la_valid_movements, factory.possible_movement)
			end
			if attached valid_kills as la_valid_kills then
				draw_valid_kill(la_valid_kills, factory.possible_kill)
			end
			draw_piece
			window.update
		end

	unselect
			-- Set the class private attributs to void
		do
			valid_movements := void
			valid_kills := void
			selected_piece := void
		ensure
			movements_cleared: valid_movements = void
			kills_cleared: valid_kills = void
			piece_unselected: selected_piece = void
		end

feature -- Public Methods

	set_agents
			-- Set the agent for the `Current'
		do
			game_library.quit_signal_actions.extend (agent quit)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

	init_ressources
			-- Initialize the ressources.
		local
			l_in_game_menu: BACKGROUND
			l_current_turn: BACKGROUND
		do
			click_sound := factory.click_sound
			create background.make(factory.game_background)
			create l_in_game_menu.make (factory.in_game_menu)
			create l_current_turn.make (factory.white_turn)
			l_in_game_menu.set_positions (600, 0)
			l_current_turn.set_positions (623, 10)
			create {LINKED_LIST[DRAWABLE]} textures.make
			textures.extend (l_in_game_menu)
			textures.extend (background)
			textures.extend (l_current_turn)
		end

	draw_all
			-- <Precursor>.
	do
		Precursor
		redraw
	end

invariant

	valid_selection: attached selected_piece implies (attached valid_movements and attached valid_kills)

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end

