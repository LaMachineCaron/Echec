note
	description: "Classe qui g�re la pi�ce pion (Pawn)."
	author: "Alexandre Caron"
	date: "02 f�vrier 2016"

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
