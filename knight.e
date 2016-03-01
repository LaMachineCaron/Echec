note
	description: "Classe qui gère la pièce cavalier (Knight)."
	author: "Alexandre Caron"
	date: "02 février 2016"

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
