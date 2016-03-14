note
	description: "Class managing the queen."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	QUEEN

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
				io.put_string ("Queen!")
			end
end
