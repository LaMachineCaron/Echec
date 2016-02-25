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

	make(a_x,a_y:INTEGER; a_renderer:GAME_RENDERER; a_image_file:STRING)

	local
		l_image:IMG_IMAGE_FILE
	do
		has_error := False
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image(a_renderer, l_image)
					set_position(a_x,a_y)
				else
					has_error := True
				end
			else
				has_error := True
			end
	end

feature

	x:INTEGER
	y:INTEGER

	set_position(a_x,a_y:INTEGER)
	local
		l_case:INTEGER -- Taille des cases
		l_border:INTEGER --Taille du rebord
	do
		l_case:=69
		l_border:=24
		x:=l_border + (a_x * l_case)
		y:=l_border + (a_y * l_case)
	end

end
