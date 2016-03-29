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
	-- When the piece is clicked.
			do
				print("Pawn!")
			end

	possible_positions(a_line, a_column:INTEGER): LIST[TUPLE[line, column:INTEGER]]
	-- Return a list of possible movements.
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make (2)
			if is_white then
				l_list.extend ([a_line + 1, a_column])
				if first_move then
					l_list.extend ([a_line + 2, a_column])
				end
			elseif is_black then
				l_list.extend ([a_line - 1, a_column])
				if first_move then
					l_list.extend ([a_line - 2, a_column])
				end
			end
			Result:=l_list
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- Return a list of possible kills.
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make(2)
			if is_white then
				if a_column > 1 then
					l_list.extend ([a_line + 1, a_column - 1])
				end
				if a_column < 8 then
					l_list.extend ([a_line + 1, a_column + 1])
				end
			elseif is_black then
				if a_column > 1 then
					l_list.extend ([a_line - 1, a_column - 1])
				end
				if a_column < 8 then
					l_list.extend ([a_line - 1, a_column + 1])
				end
			end
			Result:=l_list
		end
end
