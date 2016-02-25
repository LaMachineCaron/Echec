note
	description: "Summary description for {PIECE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PIECE

inherit
	DRAWABLE
	rename make as
		make_drawable
	end

feature {NONE}

	make(a_x,a_y:INTEGER; a_renderer:GAME_RENDERER; a_image_file:STRING; a_white_team:BOOLEAN)

	local
		l_image:IMG_IMAGE_FILE
	do
		has_error := False
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image(a_renderer, l_image)
					set_position_pieces(a_x,a_y)
					set_dimensions(68,68)
					set_first_move
					set_team(a_white_team)
				else
					has_error := True
				end
			else
				has_error := True
			end
	end

feature -- Routine

	on_click
		do
			io.put_string ("Woo!")
		end

feature -- Attributs

--	x:INTEGER -- Rendu avec Drawable
--	y:INTEGER

	first_move:BOOLEAN
	is_white:BOOLEAN -- l'équipe
	is_black:BOOLEAN -- l'équipe

--	set_position(a_x,a_y:INTEGER) -- Rendu avec Drawable (set_position_piece)
--	local
--		l_case:INTEGER -- Taille des cases
--		l_border:INTEGER --Taille du rebord
--	do
--		l_case:=69
--		l_border:=24
--		x:=l_border + (a_x * l_case)
--		y:=l_border + (a_y * l_case)
--	end

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
