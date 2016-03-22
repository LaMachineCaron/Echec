note
	description: "Class managing the game."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature{NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED)
	-- Create the engine using a window_rendered.

		local
			l_grid:GRID
			l_background:BACKGROUND
			l_game_images:GAME_IMAGES_FACTORY
			l_sound:SOUND
		do
			a_window.clear_events
			a_window.renderer.clear
			create l_game_images.make (a_window.renderer)
			create l_background.make(l_game_images.game_background, 600, 600)
			a_window.renderer.draw_texture (l_background.texture, l_background.x, l_background.y)
			create l_grid.make(a_window.renderer, l_game_images)
			create l_sound.make
			draw_piece(a_window.renderer, l_grid)
			a_window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, a_window, l_grid, l_sound, l_game_images))
			a_window.update
		end
feature -- Attributs

	selected_piece:detachable PIECE
	valid_movements:detachable LIST[TUPLE[line, column:INTEGER]]
	valid_kills:detachable LIST[TUPLE[line, column:INTEGER]]

feature -- Methods

	convert_grid_to_coord(a_grid:TUPLE[line, column:INTEGER]):TUPLE[x, y:INTEGER]
		local
			l_coord:TUPLE[x, y:INTEGER]
			l_border:INTEGER
			l_case:INTEGER
		do
			l_border:=24
			l_case:=69
			create l_coord.default_create
			l_coord.x := l_border + ((a_grid.column - 1) * l_case)
			l_coord.y := l_border + ((a_grid.line - 1) * l_case)
			Result := l_coord

		end

	calcul_valid_movement(a_possible_movement:LIST[TUPLE[line, column:INTEGER]]; a_grid:GRID)
		local
			l_valid:BOOLEAN
			l_movement:TUPLE[line, column:INTEGER]
		do
			l_valid := true
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_movements.make(a_possible_movement.count)
			across a_possible_movement as la_possible_movement loop
				if l_valid then
					if (a_grid.grid.at (la_possible_movement.item.line).at(la_possible_movement.item.column) = void) then
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

	calcul_valid_kill(a_possible_kill:LIST[TUPLE[line, column:INTEGER]]; a_grid:GRID)
		local
			l_kill:TUPLE[line, column:INTEGER]
		do
			create {ARRAYED_LIST[TUPLE[line, column:INTEGER]]} valid_kills.make (a_possible_kill.count)
			across a_possible_kill as la_possible_kill loop
				if (a_grid.grid.at (la_possible_kill.item.line).at(la_possible_kill.item.column) /= void) then
					l_kill := [la_possible_kill.item.line, la_possible_kill.item.column]
					if attached valid_kills as la_valid_kills then
						la_valid_kills.extend(l_kill)
					end
				end
			end
		end

	calcul_grid_position(a_mouse_state:GAME_MOUSE_BUTTON_PRESSED_STATE):TUPLE[line, column:INTEGER]
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

	draw_piece(a_renderer:GAME_RENDERER; a_grid:GRID)
	-- Draw every pieces contained in the grid.
		local
			l_position:TUPLE[x, y:INTEGER]
		do
			across 1 |..| 8 as la_index loop
				across 1 |..| 8 as la_index_2 loop
					if attached a_grid.grid.at (la_index.item).at (la_index_2.item) as la_piece then
						l_position := convert_grid_to_coord([la_index.item, la_index_2.item])
						la_piece.set_positions(l_position.x, l_position.y)
						a_renderer.draw_texture (la_piece.texture, l_position.x, l_position.y)
					end
				end
			end
		end

	unselect
		do
			valid_movements:=void
			valid_kills:=void
			selected_piece:=void
		end

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_grid:GRID; a_sound:SOUND; a_game_images_factory:GAME_IMAGES_FACTORY)
	-- Manage when mouse is pressed.
		local
			l_possible_movements:LIST[TUPLE[line, column:INTEGER]]
			l_possible_kill:LIST[TUPLE[line, column:INTEGER]]
			l_position:TUPLE[line, column:INTEGER]
		do
			a_sound.play
			l_position:=calcul_grid_position(a_mouse_state)
			if selected_piece /= void then
				if attached selected_piece as la_selected_piece and attached valid_movements as la_valid_movements and attached valid_kills as la_valid_kills then
					across la_valid_movements as la_movement loop
						if la_movement.item.line = l_position.line and la_movement.item.column = l_position.column then
							if attached la_selected_piece.line as la_line and attached la_selected_piece.column as la_column then
								a_grid.grid.at (la_line.item).at (la_column.item) := void
								a_grid.grid.at (l_position.line).at (l_position.column) := la_selected_piece
								la_selected_piece.set_grid_position (la_movement.item.line, la_movement.item.column)
							end
						end
					end
				end
				unselect
			else
				if attached {PIECE} a_grid.grid.at(l_position.line).at(l_position.column) as la_piece then
					la_piece.on_click -- Used for testing.
					selected_piece:=la_piece
					l_possible_movements:=la_piece.possible_positions(l_position.line, l_position.column)
					l_possible_kill:=la_piece.possible_kill (l_position.line, l_position.column)
					calcul_valid_movement(l_possible_movements, a_grid)
					calcul_valid_kill(l_possible_kill, a_grid)
				else
					unselect
				end
			end
			redraw(a_window, a_grid, a_game_images_factory) -- Redraw no matter what.
		end

	draw_valid_kill(a_window:GAME_WINDOW_RENDERED; a_valid_kill:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE; a_grid:GRID)
	-- Draw color to show killable piece.
		local
			l_coord:TUPLE[x, y:INTEGER]
		do
			across a_valid_kill as la_valid_kill loop
				l_coord:=convert_grid_to_coord(la_valid_kill.item)
				a_window.renderer.draw_texture (a_texture, l_coord.x, l_coord.y)
			end
		end

	draw_valid_movement(a_window:GAME_WINDOW_RENDERED; a_valid_positions:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE; a_grid:GRID)
	-- Draw color to show possible movement.
		local
			l_coord:TUPLE[x, y:INTEGER]
		do
			across a_valid_positions as la_valid_position loop
				l_coord:=convert_grid_to_coord(la_valid_position.item)
				a_window.renderer.draw_texture (a_texture, l_coord.x, l_coord.y)
			end
		end

	redraw (a_window:GAME_WINDOW_RENDERED; a_grid:GRID; a_game_images_factory:GAME_IMAGES_FACTORY)
	-- Redraw everything.
	do
		a_window.renderer.draw_texture (a_game_images_factory.game_background, 0, 0)
		if attached valid_movements as la_valid_movements then
			draw_valid_movement(a_window, la_valid_movements, a_game_images_factory.possible_movement, a_grid)
		end
		if attached valid_kills as la_valid_kills then
			draw_valid_kill(a_window, la_valid_kills, a_game_images_factory.possible_kill, a_grid)
		end
		draw_piece(a_window.renderer, a_grid)
		a_window.update
	end
end
