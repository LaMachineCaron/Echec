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
			l_background:BACKGROUND
			l_sprites:ARRAYED_LIST[DRAWABLE]
		do
			a_window.renderer.clear
			create l_sprites.make (1)
			create l_background.make(a_window.renderer, "./Ressources/chessboard.png", 600, 600)
			l_sprites.extend (l_background)
			l_background.set_positions(0,0)
			l_sprites.do_all(agent draw_sprite(a_window.renderer, ?))
			a_window.update
		end

feature

	draw_sprite(a_window:GAME_RENDERER; a_sprites:DRAWABLE)
		do
			a_window.draw_texture (a_sprites, a_sprites.position_x, a_sprites.position_y)
		end

end
