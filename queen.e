note
	description: "Classe pour la pièce reine (Queen)."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	QUEEN

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
				io.put_string ("Queen!")
			end
end
