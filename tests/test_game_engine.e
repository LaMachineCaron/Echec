note
	description: "Test for `game_engine' class."
	author: "Alexandre Caron"
	date: "18 April 2016"
	testing: "type/manual"

class
	TEST_GAME_ENGINE

inherit
	EQA_TEST_SET
	GRID_UTILS
		undefine
			default_create
		end

feature{NONE}



feature -- Test routines

	convert_grid_to_coord_normal
			-- Normal test for `convert_grid_to_coord_normal'.
		local
			l_coord: TUPLE[x, y:INTEGER]
		do
			l_coord := convert_grid_to_coord([4,5])
			assert ("convert_grid_to_coord - test normal", l_coord ~ [300, 231])
		end

	convert_grid_to_coord_limit
			-- Limit test for `convert_grid_to_coord'.
		local
			l_coord: TUPLE[x, y:INTEGER]
		do
			l_coord := convert_grid_to_coord([1,1])
			assert ("convert_grid_to_coord - test limit", l_coord ~ [24, 24])
		end

	convert_coord_to_grid_normal
			-- Normal test for `convert_coord_to_grid'.
		local
			l_grid_position:TUPLE[line, column:INTEGER]
		do
			l_grid_position := convert_coord_to_grid ([32, 32])
			assert ("convert_coord_to_grid - test normal", l_grid_position ~ [1, 1])
		end

	convert_coord_to_grid_limit
			-- Limit test for `convert_cord_to_grid'.
		local
			l_grid_position: TUPLE[line, column: INTEGER]
		do
			l_grid_position := convert_coord_to_grid ([800, 600])
			assert ("convert_coord_to_grid - test limit", l_grid_position ~ [0, 0])
		end



end


