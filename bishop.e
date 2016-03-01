note
	description: "Classe qui gère la pièce fou (Bishop)."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	BISHOP

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
				io.put_string ("Bishop!")
			end

end
