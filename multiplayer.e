note
	description: "Class managing multiplayer button."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	MULTIPLAYER

inherit
	BUTTONS

create
	make

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
	-- When the button is clicked.
		local
			l_multiplayer_menu:MULTIPLAYER_MENU_ENGINE
		do
			io.put_string ("Bouton Multiplayer")
			create l_multiplayer_menu.make (a_window, a_factory)
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
