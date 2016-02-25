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
			a_window.renderer.draw_texture (l_grid, l_grid.position_x, l_grid.position_y)
			l_grid.sprites.do_all(agent draw_sprite(a_window.renderer, ?))
			a_window.update
		end

feature

	draw_sprite(a_renderer:GAME_RENDERER; a_sprite:PIECE)
		do
			a_renderer.draw_texture (a_sprite, a_sprite.x, a_sprite.y)
		end

end
