note
	description: "Class managing the pawn."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	PAWN

inherit
	PIECE
		redefine
			on_click
		end

create
	make

feature -- Attributs

	move: LIST[TUPLE[line, column, max_range: INTEGER]]
			-- `line' : between -1 and 1. Represente one deplacement depending on the `piece' position.
			-- `column' : between -1 and 1. Represente one deplacement depending on the `piece' position.
			-- `max_range' : between 1 and 8. Number for deplacement possible.
		once ("PROCESS")
			create {ARRAYED_LIST[TUPLE[line, column, max_range:INTEGER]]} Result.make(4)
			Result.extend([1, 0, 1])
		end

feature -- Methods

	on_click
			-- When the `Current' is clicked.
			do
				io.put_string ("Pawn %N")
			end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
