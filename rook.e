note
	description: "Classe qui g�re la pi�ce tour (Rook)."
	author: "Alexandre Caron"
	date: "$02 f�vrier 2016"

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
