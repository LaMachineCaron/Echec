note
	description: "Class managing the rook."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	ROOK

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
				io.put_string ("Rook!")
			end

end
