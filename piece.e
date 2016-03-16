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
		do
			texture := a_texture
			set_dimensions(68,68)
			set_first_move
			set_team(a_white_team)
		end

feature -- Attributs

	first_move: BOOLEAN
	is_white: BOOLEAN -- l'équipe
	is_black: BOOLEAN -- l'équipe

feature -- Methods

	on_click
		do
			io.put_string ("Default")
		end

	possible_positions(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
		deferred
		end

	possible_kill(a_line, a_column:INTEGER) :LIST[TUPLE[line, column:INTEGER]]
		deferred
		end

	set_first_move
		do
			first_move:=True
		end

	set_team(a_white_team:BOOLEAN)
		do
			is_white:=a_white_team
			is_black:=not a_white_team
		end


end
