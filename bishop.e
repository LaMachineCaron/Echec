note
	description: "Manage bishops."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	BISHOP

inherit
	PIECE
		redefine
			on_click
		end

create
	make

feature -- Attributs

	move: LIST[TUPLE[line, column, max_range: INTEGER]]
			-- <Precusor>
		once ("PROCESS")
			create {ARRAYED_LIST[TUPLE[line, column, max_range:INTEGER]]} Result.make(4)
			Result.extend([1, 1, 8])
			Result.extend([-1, 1, 8])
			Result.extend([-1, -1, 8])
			Result.extend([1, -1, 8])
		end

feature -- Methods

	on_click
			-- When the piece is clicked. Debug purposes.
			do
				io.put_string ("Bishop %N")
			end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
