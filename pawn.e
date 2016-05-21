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
		do
			if is_first_move then
				Result := first_move
			else
				Result := not_first_move
			end
		end

feature -- Methods

	on_click
			-- When the `Current' is clicked.
			do
				io.put_string ("Pawn %N")
			end

	first_move: LIST[TUPLE[line, column, max_range: INTEGER]]
			-- set the max_range from `move' to 2.
		once("PROCESS")
			create {ARRAYED_LIST[TUPLE[line, column, max_range:INTEGER]]} Result.make(1)
			Result.extend([1, 0, 2])
		end

	not_first_move: LIST[TUPLE[line, column, max_range: INTEGER]]
			-- Set the max_range from `move' to 1.
		once("PROCESS")
			create {ARRAYED_LIST[TUPLE[line, column, max_range:INTEGER]]} Result.make(1)
			Result.extend([1, 0, 1])
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
