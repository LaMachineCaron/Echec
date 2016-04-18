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
			l_coord := convert_grid_to_coord([1,1])
			assert ("convert_grid_to_coord - test normal", l_coord ~ [24,24])
		end

end


