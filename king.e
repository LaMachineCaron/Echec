note
	description: "Class managing the king."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	KING

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
				io.put_string ("King!")
			end
end
