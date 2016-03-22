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

	calcul_position(a_grid_x, a_grid_y:INTEGER) :TUPLE[x, y:INTEGER]
	local
		l_x:INTEGER
		l_y:INTEGER
		l_border:INTEGER
		l_case:INTEGER
	do
		l_case := 69
		l_border := 24
		l_x := l_border + ((a_grid_x - 1) * l_case)
		l_y := l_border + ((a_grid_y - 1) * l_case)
		Result := [l_x, l_y]
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
					if (a_grid.grid.at (la_possible_movement.item.integer_32_item (1)).at(la_possible_movement.item.integer_32_item (2)) = void) then
						l_movement := calcul_position(la_possible_movement.item.integer_32_item (2), la_possible_movement.item.integer_32_item (1))
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
				if (a_grid.grid.at (la_possible_kill.item.integer_32_item (1)).at(la_possible_kill.item.integer_32_item (2)) /= void) then
					l_kill := calcul_position(la_possible_kill.item.integer_32_item (1), la_possible_kill.item.integer_32_item (2))
					if attached valid_kills as la_valid_kills then
						la_valid_kills.extend(l_kill)
					end
				end
			end

		end

	draw_piece(a_renderer:GAME_RENDERER; a_grid:GRID)
	-- Draw every pieces contained in the grid.
		local
			l_x:INTEGER
			l_y:INTEGER
			l_positions:TUPLE[x, y:INTEGER]
		do
			across 1 |..| 8 as la_index loop
				across 1 |..| 8 as la_index_2 loop
					if attached a_grid.grid.at (la_index.item).at (la_index_2.item) as la_piece then
						l_positions := calcul_position(la_index_2.item, la_index.item)
						l_x := l_positions.integer_32_item (1)
						l_y := l_positions.integer_32_item (2)
						la_piece.set_positions(l_x, l_y)
						a_renderer.draw_texture (la_piece.texture, l_x, l_y)
					end
				end
			end
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_grid:GRID; a_sound:SOUND; a_game_images_factory:GAME_IMAGES_FACTORY)
	-- Manage when mouse is pressed.
		local
			l_possible_movements:LIST[TUPLE[line, column:INTEGER]]
			l_possible_kill:LIST[TUPLE[line, column:INTEGER]]
			l_unselect:BOOLEAN
		do
			l_unselect:=True
			a_sound.play
			across a_grid.grid as la_line loop
				across la_line.item as la_column loop
					if cursor_over_sprite(mouse_state, la_column.item) then
						if attached {PIECE} la_column.item as la_piece then
						l_unselect:=False
							la_piece.on_click -- Used for testing.
							selected_piece:=la_piece
							l_possible_movements:=la_piece.possible_positions(la_line.cursor_index, la_column.cursor_index)
							l_possible_kill:=la_piece.possible_kill (la_line.cursor_index, la_column.cursor_index)
							calcul_valid_movement(l_possible_movements, a_grid)
							calcul_valid_kill(l_possible_kill, a_grid)
						end
					else
						-- Manage deplacement.
					end
				end
			end
			if l_unselect then
				valid_movements:=void
				valid_kills:=void
				selected_piece:=void
			end
			redraw(a_window, a_grid, a_game_images_factory) -- Redraw no matter what.
		end

	draw_valid_kill(a_window:GAME_WINDOW_RENDERED; a_valid_kill:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE; a_grid:GRID)
	-- Draw color to show killable piece.
		do
			across a_valid_kill as la_valid_kill loop
				a_window.renderer.draw_texture (a_texture, la_valid_kill.item.integer_32_item (2), la_valid_kill.item.integer_32_item (1))
			end
		end

	draw_valid_movement(a_window:GAME_WINDOW_RENDERED; a_valid_positions:LIST[TUPLE[line, column:INTEGER]]; a_texture:GAME_TEXTURE; a_grid:GRID)
	-- Draw color to show possible movement.
		do
			across a_valid_positions as la_valide_position loop
				a_window.renderer.draw_texture (a_texture, la_valide_position.item.integer_32_item (1), la_valide_position.item.integer_32_item (2))
			end
		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:detachable PIECE):BOOLEAN
	-- Check if there's a sprite under the cursor.
		local
			l_over:BOOLEAN
		do
			l_over:= False
			if attached a_sprite as la_piece then
				if (a_mouse_stat.x > la_piece.x) and (a_mouse_stat.x < la_piece.x + la_piece.width) then
					if (a_mouse_stat.y > la_piece.y) and (a_mouse_stat.y < la_piece.y + la_piece.height) then
						l_over := True
					end
				end
				Result := l_over
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
