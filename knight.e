note
	description: "Classe qui g�re la pi�ce cavalier (Knight)."
	author: "Alexandre Caron"
	date: "02 f�vrier 2016"

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
