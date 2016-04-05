note
	description: "Manage the back button."
	author: "Alexandre Caron"
	date: "05 April"

class
	RETURN

inherit
	BUTTON

create
	make,
	make_with_position

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY)
	-- Return to the main menu.
		local
			l_menu_engine:MENU_ENGINE
		do
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
