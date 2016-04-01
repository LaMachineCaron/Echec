note
	description: "Class managing the multiplayer menu."
	author: "Alexandre Caron"
	date: "30 March 2016"

class
	MULTIPLAYER_MENU_ENGINE

inherit
	ENGINES

create
	make

feature {NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
		local
			--l_test_text:TEXT
		do
			a_window.clear_events
			a_window.renderer.clear
			factory := a_factory
			click_sound := a_factory.click_sound
			create background.make (factory.menu_background)
			a_window.renderer.draw_texture (background.texture, background.x, background.y)
			--create l_test_text.make ("Test", a_factory, a_window.renderer)
			--a_window.renderer.draw_texture (l_test_text.texture, 100, 100)
			a_window.update
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
