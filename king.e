note
	description: "Classe qui g�re la pi�ce roi (King)."
	author: "Alexandre Caron"
	date: "02 f�vrier 2016"

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
