note
	description: "Class managing the knight."
	author: "Alexandre Caron"
	date: "02 february 2016"

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
	-- When the piece is clicked.
			do
				io.put_string ("Knight!")
			end

	possible_positions(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- Return a list on possible movements.
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make(0)
			Result:=l_list
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- Return a list of possible kills. (Same as possible_positions for this piece)
		do
			Result:=possible_positions(a_line, a_column)
		end


end
