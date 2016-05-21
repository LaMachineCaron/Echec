note
	description: "Class managing the king."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	KING

inherit
	PIECE
		redefine
			on_click
		end

create
	make

feature -- Attributs

	move: LIST[TUPLE[line, column, max_range: INTEGER]]
			-- <Precursor>
		once ("PROCESS")
			create {ARRAYED_LIST[TUPLE[line, column, max_range:INTEGER]]} Result.make(4)
			Result.extend([1, 0, 1])
			Result.extend([-1, 0, 1])
			Result.extend([0, -1, 1])
			Result.extend([0, 1, 1])
			Result.extend([1, 1, 1])
			Result.extend([-1, 1, 1])
			Result.extend([1, -1, 1])
			Result.extend([-1, -1, 1])
		end

feature -- Methods

	on_click
			-- When the `Current' is clicked.
			do
				io.put_string ("King %N")
			end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
