note
	description: "Classe abstraite pour les objets qui on une texture."
	author: "Alexandre Caron"
	date: "02 février 2016"

deferred class
	DRAWABLE

feature {NONE} -- Initialization

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

feature -- Attributs

	texture: GAME_TEXTURE
	x: INTEGER
	y: INTEGER
	dimension_x: INTEGER
	dimension_y: INTEGER

feature -- Methods

	set_positions (a_x, a_y:INTEGER)
		do
			x:= a_x
			y:= a_y
		end

	set_dimensions (a_dimension_x:INTEGER; a_dimension_y:INTEGER)
		do
			dimension_x := a_dimension_x
			dimension_y := a_dimension_y
		end
end
