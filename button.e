note
	description: "Abstract class for buttons."
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	BUTTON

inherit
	DRAWABLE

feature -- Initialization

	make_with_position(a_texture: GAME_TEXTURE; a_x, a_y: INTEGER)
	-- Create the `Current' using his position.
		require
			valid_a_x: a_x >= 0
			valid_a_y: a_y >= 0
		do
			set_positions (a_x, a_y)
			texture := a_texture
			set_dimensions
		end

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
	-- When `Current' is clicked.
		deferred
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
