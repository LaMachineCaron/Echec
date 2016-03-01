note
	description: "Summary description for {PION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAWN

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
				io.put_string ("Pawn!")
			end

end
