note
	description: "Class managing the queen."
	author: "Alexandre Caron"
	date: "02 february 2016"

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
	-- When the `Current' is clicked.
			do
				io.put_string ("Queen %N")
			end

	possible_positions(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- Return a list of possible movements.
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make(0)
			Result:=l_list
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- Return a list of possible kills. (Same as possible_positions of this piece)
		do
			Result:=possible_positions(a_line, a_column)
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
