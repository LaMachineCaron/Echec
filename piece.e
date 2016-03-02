note
	description: "Classe abstraite pour les pièces"
	author: "Alexandre Caron"
	date: "02 février 2016"

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

	set_first_move
		do
			first_move:=True
		end

	set_team(a_white_team:BOOLEAN)
		do
			if a_white_team then
				is_white:=True
				is_black:=False
			else
				is_white:=False
				is_black:=True
			end
		end


end
