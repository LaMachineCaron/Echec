note
	description: "Button that execute agents when clicked."
	author: "Alexandre Caron / Guillaume Jean"
	date: "10 April 2016"

class
	BUTTON

inherit
	DRAWABLE
		rename
			make as make_drawable
		end

create
	make

feature -- Initialization

	make(a_texture: GAME_TEXTURE; a_x, a_y: INTEGER; a_action:PROCEDURE[ANY, TUPLE])
			-- Create the `Current'.
		do
			make_with_position (a_texture, a_x, a_y)
			action := a_action
		end

feature -- Attributs

	action: PROCEDURE[ANY, TUPLE]
			--  The agent that the `Current' will launch.

feature -- Methods

	on_click
			-- Call the `action'
		do
			action.call
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
	credit:	   "The mecanism of this class come from Guillaume Jean. I took it for his project 'Sickbeat' with his approval."
end
