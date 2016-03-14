note
	description: "Class managing the knight."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	KNIGHT

inherit
	PIECE
		redefine
			on_click
		end

create
	make

feature -- Methods

	on_click
			do
				io.put_string ("Knight!")
			end

end
