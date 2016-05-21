note
	description: "Utilities for the grid."
	author: "Alexandre Caron"
	date: "March 2016"

deferred class
	GRID_UTILS


feature {NONE} -- Private Methods

	convert_grid_to_coord(a_position:TUPLE[line, column:INTEGER]):TUPLE[x, y:INTEGER]
			-- Convert a matrix position (line, column) to a window position (x, y)
		require
			valid_line: a_position.line > 0 and a_position.line < 9
			valid_column: a_position.column > 0 and a_position.column < 9
		local
			l_coord:TUPLE[x, y:INTEGER]
			l_border:INTEGER
			l_case:INTEGER
		do
			l_border:=24
			l_case:=69
			create l_coord.default_create
			l_coord.x := l_border + ((a_position.column - 1) * l_case)
			l_coord.y := l_border + ((a_position.line - 1) * l_case)
			Result := l_coord
		ensure
			valid_coord: result.x >= 0 and result.y >= 0
		end

	convert_coord_to_grid(a_position: TUPLE[x, y: INTEGER]):TUPLE[line, column:INTEGER]
			-- Convert a window position (x, y) to a matrix position (line, column)
			-- Return [0,0] if the click wasn't in the grid.
		require
			valid_x: a_position.x >= 0
			valid_y: a_position.y >= 0
		local
			l_position:TUPLE[line, column:INTEGER]
			l_border:INTEGER
			l_case:INTEGER
		do
			l_border:=24
			l_case:=69
			create l_position.default_create
			l_position.line := ((a_position.y - l_border) // l_case) + 1
			l_position.column := ((a_position.x - l_border) // l_case) + 1
			result := l_position
			if l_position.line > 0 and l_position.column < 9 and l_position.column > 0 and l_position.column < 9 then
				result := l_position
			else
				result := [0,0]
			end
		end
end
