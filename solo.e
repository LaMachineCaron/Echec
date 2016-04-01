note
	description: "Class managing solo button."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	SOLO

inherit
	BUTTONS

create
	make

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY)
	-- Create the game engine.
		local
			l_game_engine:GAME_ENGINE
		do
			create l_game_engine.make(a_window, a_factory)
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
