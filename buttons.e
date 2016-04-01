note
	description: "Abstract class for buttons."
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	BUTTONS

inherit
	DRAWABLE

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
	-- When the button is clicked.
		deferred
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
