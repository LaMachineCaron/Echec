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
			-- Create a `Current'.
		do
			texture := a_texture
			set_first_move
			set_team(a_white_team)
		end

feature -- Attributs

	first_move: BOOLEAN
			-- If it is the first time this piece move.
	is_white: BOOLEAN
			-- Team
	is_black: BOOLEAN
			-- Team
	position: detachable TUPLE[line, column:INTEGER]
			-- Grid line and Grid column.
	max_range: INTEGER
			-- Number of deplacement possible
	side: INTEGER
			-- 1 for white, -1 for black
	move: LIST[TUPLE[line, column, max_range:INTEGER]]
			-- `line' : between -1 and 1. Represente one deplacement depending on the `piece' position.
			-- `column' : between -1 and 1. Represente one deplacement depending on the `piece' position.
			-- `max_range' : between 1 and 8. Number for deplacement possible.
		deferred
		end

feature -- Methods

	first_move_done
		do
			first_move := False
		end

	on_click
			-- When the piece is clicked.
		do
			io.put_string ("Default")
		end

	set_grid_position(a_line, a_column:INTEGER)
			-- modifiy `line' and `column' attribut from a piece.
		require -- Line and column are between 1 and 8.
			valid_line: a_line <= 8 and a_line >= 1
			valid_column: a_column <= 8 and a_column >= 1
		do
			if attached position as la_position then
				la_position.line:=a_line
				la_position.column:=a_column
			else
				create position.default_create
				if attached position as la_position then
					la_position.line := a_line
					la_position.column := a_column
				end
			end
		end

	set_first_move
			-- Set `first_move' at True.
		do
			first_move:=True
		end

	set_team(a_white_team:BOOLEAN)
			-- set team color.
		do
			is_white:=a_white_team
			is_black:=not a_white_team
			if a_white_team then
				side := 1
			else
				side := -1
			end
		ensure
			valid_team: is_white = not is_black
		end

invariant
	valid_team: is_black = not is_white

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
