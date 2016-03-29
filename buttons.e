note
	description: "Abstract class for buttons."
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	BUTTONS

inherit
	DRAWABLE

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED)
	-- When the button is clicked.
		deferred
		end

end
