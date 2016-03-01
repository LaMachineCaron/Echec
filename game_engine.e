note
	description: "Summary description for {GAME_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature{NONE}

	make(a_window:GAME_WINDOW_RENDERED)

		local
			l_grid:GRID
			l_background:BACKGROUND
		do
			a_window.clear_events
			a_window.renderer.clear
			create l_background.make(a_window.renderer, "./Ressources/chessboard.png", 600, 600)
			l_background.set_positions(0,0)
			a_window.renderer.draw_texture (l_background.texture, l_background.x, l_background.y)
			create l_grid.make(a_window.renderer)
			draw_piece(a_window.renderer, l_grid)
			a_window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, a_window, l_grid))
			a_window.update
		end

feature

	draw_piece(a_renderer:GAME_RENDERER; a_grid:GRID)
		local
			l_x:INTEGER
			l_y:INTEGER
			l_border:INTEGER
			l_case:INTEGER
		do
			l_case := 69
			l_border := 24
			across 1 |..| 8 as la_index loop
				across 1 |..| 8 as la_index_2 loop
					if attached a_grid.grid.at (la_index.item).at (la_index_2.item) as la_piece then
						l_x := l_border + ((la_index_2.item - 1) * l_case)
						l_y := l_border + ((la_index.item - 1) * l_case)
						la_piece.set_positions(l_x, l_y)
						a_renderer.draw_texture (la_piece.texture, l_x, l_y)
					end
				end
			end
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_grid:GRID)
		do
			across a_grid.grid as la_line loop
				across la_line.item as la_column loop
					if cursor_over_sprite(mouse_state, la_column.item) then
						if attached {PIECE} la_column.item as la_piece then
							la_piece.on_click
						end
					end
				end

			end
		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:detachable PIECE):BOOLEAN
		local
			l_over:BOOLEAN
		do
			l_over:= False
			if attached a_sprite as la_piece then
				if (a_mouse_stat.x > la_piece.x) and (a_mouse_stat.x < la_piece.x + la_piece.dimension_x) then
					if (a_mouse_stat.y > la_piece.y) and (a_mouse_stat.y < la_piece.y + la_piece.dimension_y) then
						l_over := True
					end
				end
				Result := l_over
			end

		end


end
