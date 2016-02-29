note
	description: "Summary description for {DRAWABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DRAWABLE

feature {NONE}

	make(a_renderer: GAME_RENDERER; a_image_file: STRING; a_dimension_x: INTEGER; a_dimension_y: INTEGER)
		local
			l_image:IMG_IMAGE_FILE
		do
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create texture.make_from_image(a_renderer, l_image)
					set_dimensions(a_dimension_x, a_dimension_y)
				else
					default_image(a_renderer)
				end
			else
				default_image(a_renderer)
			end
		end

	default_image(a_renderer:GAME_RENDERER)
		local
			l_pixel_format:GAME_PIXEL_FORMAT
		do
			create l_pixel_format.default_create
			l_pixel_format.set_index1lsb
			create {GAME_TEXTURE_TARGET}texture.make (a_renderer, l_pixel_format, 0, 0)
		end

feature
	-- Variables

	texture: GAME_TEXTURE
	x: INTEGER
	y: INTEGER
	dimension_x: INTEGER
	dimension_y: INTEGER

	set_positions (a_x, a_y:INTEGER)
		do
			x:= a_x
			y:= a_y
		end

	set_position_pieces (a_x, a_y:INTEGER)
		local
			l_case:INTEGER -- Taille des cases
			l_border:INTEGER --Taille du rebord
		do
			l_case:=69
			l_border:=24
			x:=l_border + (a_x * l_case)
			y:=l_border + (a_y * l_case)
		end

	set_dimensions (a_dimension_x:INTEGER; a_dimension_y:INTEGER)
		do
			dimension_x := a_dimension_x
			dimension_y := a_dimension_y
		end
end
