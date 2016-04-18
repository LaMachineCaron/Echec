note
	description: "Summary description for {GRID_UTILS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		end
end
