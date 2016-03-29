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

feature -- Methods

	on_click
	-- When the piece is clicked.
			do
				io.put_string ("King!")
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
	-- Return a list of possible kills. (Same this as possible_movement for this piece)
		do
			Result:=possible_positions(a_line, a_column)
		end

end
