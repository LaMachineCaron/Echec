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

feature -- Methods

	on_click
	-- When the piece is clicked.Debug purposes.
			do
				io.put_string ("Bishop!")
			end

	possible_positions(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- return a `list` of possible deplacement (Grid position)
		local
			l_list:ARRAYED_LIST[TUPLE[line, column:INTEGER]]
		do
			create l_list.make(0)
			Result:=l_list
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
	-- return a `list` of possible kill (Grid position)
		local
			l_list:LIST[TUPLE[line, column:INTEGER]]
		do
			l_list:=possible_positions(a_line, a_column)
			Result:=l_list
		end


end
