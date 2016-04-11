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

create
	make

feature{NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY)
	-- Create an `Current'.
		do
			factory := a_factory
			window := a_window
			create grid.make(window.renderer, factory)
			init_ressources
		end

feature -- Attributs

	selected_piece:detachable PIECE -- The current `piece' selected
	valid_movements:detachable LIST[TUPLE[line, column:INTEGER]] -- List of valid movements for the selected `piece'
	valid_kills:detachable LIST[TUPLE[line, column:INTEGER]] -- List of valid kills for the selected `piece'
	grid: GRID -- The grid containing every `piece' and there position.

feature -- Methods

	set_agents
			-- Set the agent for the `Current'
		do
			game_library.quit_signal_actions.extend (agent quit)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

	convert_grid_to_coord(a_position:TUPLE[line, column:INTEGER]):TUPLE[x, y:INTEGER]
			-- Convert a matrix position (line, column) to a window position (x, y)
		local
			l_coord:TUPLE[x, y:INTEGER]
			l_border:INTEGER
			l_case:INTEGER
		do
			l_border:=24
			l_case:=69
			create l_coord.default_create
			l_coord.x := l_border + ((a_position.column - 1) * l_case)
			l_coord.y := l_border + ((a_position.line - 1) * l_case)
			Result := l_coord

		end

	convert_coord_to_grid(a_mouse_state:GAME_MOUSE_BUTTON_PRESSED_STATE):TUPLE[line, column:INTEGER]
			-- Convert a window position (x, y) to a matrix position (line, column)
		local
			l_position:TUPLE[line, column:INTEGER]
			l_border:INTEGER
			l_case:INTEGER
		do
			l_border:=24
			l_case:=69
			create l_position.default_create
			l_position.line:=((a_mouse_state.y - l_border) // l_case) + 1
			l_position.column:=((a_mouse_state.x - l_border) // l_case) + 1
			result:=l_position
		end

	calcul_valid_movement(a_possible_movement:LIST[TUPLE[line, column:INTEGER]])
			-- Put every valid movement of a `piece' in a list of valid movements.
		local
			l_valid:BOOLEAN
			l_movement:TUPLE[line, column:INTEGER]
		do
			l_valid := true
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_movements.make(a_possible_movement.count)
			across a_possible_movement as la_possible_movement loop
				if l_valid then
					if (grid.grid.at (la_possible_movement.item.line).at(la_possible_movement.item.column) = void) then
						l_movement := [la_possible_movement.item.line, la_possible_movement.item.column]
						if attached valid_movements as la_valid_movements then
							la_valid_movements.extend(l_movement)
						end
					else
						l_valid := false
					end
				end
			end
		end

	calcul_valid_kill(a_possible_kill:LIST[TUPLE[line, column:INTEGER]])
			-- Put every valid kill of a `piece' in a list of valid kills.
		local
			l_kill:TUPLE[line, column:INTEGER]
		do
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_kills.make (a_possible_kill.count)
			across a_possible_kill as la_possible_kill loop
				if (grid.grid.at (la_possible_kill.item.line).at(la_possible_kill.item.column) /= void) then
					l_kill := [la_possible_kill.item.line, la_possible_kill.item.column]
					if attached valid_kills as la_valid_kills then
						la_valid_kills.extend(l_kill)
					end
				end
			end
		end

	draw_piece
			-- Draw every pieces contained in the grid.
		local
			l_position:TUPLE[x, y:INTEGER]
		do
			across 1 |..| 8 as la_index loop
				across 1 |..| 8 as la_index_2 loop
					if attached grid.grid.at (la_index.item).at (la_index_2.item) as la_piece then
						l_position := convert_grid_to_coord([la_index.item, la_index_2.item])
						la_piece.set_positions(l_position.x, l_position.y)
						window.renderer.draw_texture (la_piece.texture, l_position.x, l_position.y)
					end
				end
			end
		end

	unselect
			-- Set the class attributs to void
		do
			valid_movements:=void
			valid_kills:=void
			selected_piece:=void
		ensure
			movements_cleared: valid_movements = void
			kills_cleared: valid_kills = void
			piece_unselected: selected_piece = void
		end

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Manage when mouse is pressed.
		local
			l_possible_movements:LIST[TUPLE[line, column:INTEGER]]
			l_possible_kill:LIST[TUPLE[line, column:INTEGER]]
			l_position:TUPLE[line, column:INTEGER]
		do
			click_sound.play_once
			l_position:=convert_coord_to_grid(a_mouse_state)
			if l_position.line <= 8 and l_position.line >= 0 and l_position.column <= 8 and l_position.column >= 0 then
				if selected_piece /= void then
					if attached selected_piece as la_selected_piece and attached valid_movements as la_valid_movements and attached valid_kills as la_valid_kills then
						across la_valid_movements as la_movement loop
							if la_movement.item.line = l_position.line and la_movement.item.column = l_position.column then
								if attached la_selected_piece.line as la_line and attached la_selected_piece.column as la_column then
									grid.grid.at (la_line.item).at (la_column.item) := void
									grid.grid.at (l_position.line).at (l_position.column) := la_selected_piece
									la_selected_piece.set_grid_position (la_movement.item.line, la_movement.item.column)
								end
							end
						end
					end
					unselect
				else
					if attached {PIECE} grid.grid.at(l_position.line).at(l_position.column) as la_piece then
						la_piece.on_click -- Used for testing.
						selected_piece:=la_piece
						l_possible_movements:=la_piece.possible_positions(l_position.line, l_position.column)
						l_possible_kill:=la_piece.possible_kill (l_position.line, l_position.column)
						calcul_valid_movement(l_possible_movements)
						calcul_valid_kill(l_possible_kill)
					else
						unselect
					end
				end
				draw_all -- Redraw no matter what.
			end
		end

	init_ressources
			-- Initialize the ressources.
		do
			click_sound := factory.click_sound
			create background.make(factory.game_background)
			create {LINKED_LIST[DRAWABLE]} textures.make
			textures.extend (background)
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

	draw_all
			-- <Precursor>.
	do
		Precursor
		redraw
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

invariant

	valid_selection: attached selected_piece implies (attached valid_movements and attached valid_kills)

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
