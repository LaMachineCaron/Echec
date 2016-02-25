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
		do
			a_window.clear_events
			a_window.renderer.clear
			create l_grid.make(a_window.renderer, "./Ressources/chessboard.png", 600, 600)
			l_grid.set_positions(0,0)
			a_window.renderer.draw_texture (l_grid, l_grid.x, l_grid.y)
			l_grid.sprites.do_all(agent draw_sprite(a_window.renderer, ?))
			a_window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, a_window, l_grid.sprites))
			a_window.update
		end

feature

	draw_sprite(a_renderer:GAME_RENDERER; a_sprite:PIECE)
		do
			a_renderer.draw_texture (a_sprite, a_sprite.x, a_sprite.y)
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_sprites:ARRAYED_LIST[DRAWABLE])
		do
			across a_sprites as la_sprites loop
				if cursor_over_sprite(mouse_state, la_sprites.item) then
					if attached {PIECE} la_sprites.item as la_piece then
						la_piece.on_click
					end
				end
			end
		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:DRAWABLE):BOOLEAN
		local
			l_over:BOOLEAN
		do
			l_over:= False
			if (a_mouse_stat.x > a_sprite.x) and (a_mouse_stat.x < a_sprite.x + a_sprite.dimension_x) then
				if (a_mouse_stat.y > a_sprite.y) and (a_mouse_stat.y < a_sprite.y + a_sprite.dimension_y) then
					l_over := True
				end
			end
			Result := l_over
		end


end
