note
	description: "Class managing the game."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	GAME_ENGINE

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
			init_ressources
		end

feature -- Attributs

	selected_piece:detachable PIECE -- The current `piece' selected
	valid_movements:detachable LIST[TUPLE[line, column:INTEGER]] -- List of valid movements for the selected `piece'
	valid_kills:detachable LIST[TUPLE[line, column:INTEGER]] -- List of valid kills for the selected `piece'
	grid: GRID -- The grid containing every `piece' and there position.
	is_white_turn: BOOLEAN -- True when it is white turn, False if black turn.

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

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Manage when mouse is pressed.
		local
			l_position:TUPLE[line, column:INTEGER]
		do
			click_sound.play_once
			l_position := convert_coord_to_grid([a_mouse_state.x, a_mouse_state.y])
			if l_position.line /= 0 and l_position.column /= 0 then
				if selected_piece /= void then
					if attached selected_piece as la_selected_piece and attached valid_movements as la_valid_movements and attached valid_kills as la_valid_kills then
						-- Normal Deplacement
						across la_valid_movements as la_movement loop
							if la_movement.item.line = l_position.line and la_movement.item.column = l_position.column then
								if attached la_selected_piece.position as la_position then
									grid.grid.at (la_position.line).at (la_position.column) := void
									grid.grid.at (l_position.line).at (l_position.column) := la_selected_piece
									la_selected_piece.set_grid_position (la_movement.item.line, la_movement.item.column)
									la_selected_piece.first_move_done
									toggle_turn
								end
							end
						end
						-- Kill
						across la_valid_kills as la_kill loop
							print(la_kill.item.out + "%N")
							if la_kill.item.line = l_position.line and la_kill.item.column = l_position.column then
								if attached la_selected_piece.position as la_position then
									grid.grid.at (la_position.line).at (la_position.column) := void
									grid.grid.at (l_position.line).at (l_position.column) := la_selected_piece
									la_selected_piece.set_grid_position (la_kill.item.line, la_kill.item.column)
									toggle_turn
								end
							end
						end
					end
					unselect
				else
					if attached {PIECE} grid.grid.at(l_position.line).at(l_position.column) as la_piece then
						if (la_piece.is_white and is_white_turn) or (la_piece.is_black and not is_white_turn) then
							la_piece.on_click -- Used for testing.
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

	toggle_turn
			-- Toggle things for the other team turn.
		do
			is_white_turn := not is_white_turn
			across textures as la_texture loop
				if la_texture.item.texture = factory.white_turn then
					la_texture.item.texture := factory.black_turn
				elseif la_texture.item.texture = factory.black_turn then
					la_texture.item.texture := factory.white_turn
				end
			end
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
			-- Set the class attributs to void
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
