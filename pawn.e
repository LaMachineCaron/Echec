note
	description: "Class managing the pawn."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	PAWN

inherit
	PIECE
		redefine
			on_click,
			possible_positions
		end

create
	make

feature -- Methods

	on_click
			do
				print("Pawn!")
			end

	possible_positions(a_line, a_column:INTEGER): LIST[TUPLE[line, column:INTEGER]]
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make (2)
			l_list.extend ([a_line + 1, a_column])
			if first_move then
				l_list.extend ([a_line + 2, a_column])
			end
			Result:=l_list
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make(2)
			if a_column > 1 then
				l_list.extend ([a_line + 1, a_column - 1])
			end
			if a_column < 8 then
				l_list.extend ([a_line + 1, a_column + 1])
			end
			Result:=l_list
		end
end
