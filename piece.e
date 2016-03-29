note
	description: "Abstract class for pieces"
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	PIECE

inherit
	DRAWABLE
		rename make as
			make_drawable
		end

feature {NONE} -- Initialization

	make(a_texture:GAME_TEXTURE; a_white_team:BOOLEAN)
	-- Create a piece.
		do
			texture := a_texture
			set_dimensions(68,68)
			set_first_move
			set_team(a_white_team)
		end

feature -- Attributs

	first_move: BOOLEAN -- If it is the first time this piece move.
	is_white: BOOLEAN -- Team
	is_black: BOOLEAN -- Team
	line:detachable INTEGER -- Grid line
	column:detachable INTEGER -- Grid column

feature -- Methods

	on_click
	-- When the piece is clicked.
		do
			io.put_string ("Default")
		end

	possible_positions(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
		deferred
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
		deferred
		end

	set_grid_position(a_line, a_column:INTEGER)
	-- modifiy `line`and `column` attribut from a piece.
		require -- Line and column are between 1 and 8.
			valid_line: a_line <= 8 and a_line >= 1
			valid_column: a_column <= 8 and a_column >= 1
		do
			line:=a_line
			column:=a_column
		ensure -- Make sure the line or the column is modified.
			position_modified: old line /= line or old column /= column
		end

	set_first_move
	-- Set `first_move` at True.
		do
			first_move:=True
		end

	set_team(a_white_team:BOOLEAN)
	-- set team color.
		do
			is_white:=a_white_team
			is_black:=not a_white_team
		ensure
			valid_team: is_white = not is_black
		end


end
