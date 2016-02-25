note
	description: "Summary description for {DRAWABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DRAWABLE

inherit
	GAME_TEXTURE
		rename
			make as make_texture
		end

feature {NONE}

	make(a_renderer: GAME_RENDERER; a_image_file: STRING; a_dimension_x: INTEGER; a_dimension_y: INTEGER)
		local
			l_image:IMG_IMAGE_FILE
		do
			has_error := False
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image(a_renderer, l_image)
					set_dimensions(a_dimension_x, a_dimension_y)
				else
					has_error := True
				end
			else
				has_error := True
			end
		end

feature
	-- Variables

	position_x:INTEGER
	position_y:INTEGER
	dimension_x:INTEGER
	dimension_y:INTEGER

	set_positions (a_position_x:INTEGER; a_position_y:INTEGER)
		do
			position_x:= a_position_x
			position_y:= a_position_y
		end

	set_dimensions (a_dimension_x:INTEGER; a_dimension_y:INTEGER)
		do
			dimension_x := a_dimension_x
			dimension_y := a_dimension_y
		end
end
