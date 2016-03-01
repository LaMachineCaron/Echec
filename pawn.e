note
	description: "Classe qui gère la pièce pion (Pawn)."
	author: "Alexandre Caron"
	date: "02 février 2016"

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
