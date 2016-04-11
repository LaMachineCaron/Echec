note
	description: "Button that execute agents when clicked."
	author: "Alexandre Caron / Guillaume Jean"
	date: "10 April 2016"

class
	BUTTON

inherit
	DRAWABLE

create
	make_with_position

feature -- Initialization

	make_with_position(a_texture: GAME_TEXTURE; a_x, a_y: INTEGER; a_action:PROCEDURE[ANY, TUPLE])
	-- Create the `Current' using his position.
		require
			valid_a_x: a_x >= 0
			valid_a_y: a_y >= 0
		do
			set_positions (a_x, a_y)
			texture := a_texture
			set_dimensions
			action := a_action
		end

feature -- Attributs

	action: PROCEDURE[ANY, TUPLE]

feature -- Methods

	on_click
		do
			action.call
		end

invariant

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
	credit:	   "The mecanism of this class come from Guillaume Jean. I took it for his project 'Sickbeat' with his approval."
end
