note
	description: "Abstract class for images facotries."
	author: "Alexandre Caron"
	date: "01 March 2016"

deferred class
	IMAGES_FACTORY

feature -- Methods

	set_texture(a_renderer:GAME_RENDERER; a_image_file:STRING):GAME_TEXTURE
		local
			l_image:IMG_IMAGE_FILE
			l_texture:GAME_TEXTURE
		do
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create l_texture.make_from_image (a_renderer, l_image)
				else
					l_texture := default_image(a_renderer)
				end
			else
				l_texture := default_image(a_renderer)
			end
			result := l_texture
		end

	default_image(a_renderer:GAME_RENDERER):GAME_TEXTURE
		local
			l_pixel_format:GAME_PIXEL_FORMAT
			l_texture:GAME_TEXTURE
		do
			create l_pixel_format.default_create
			l_pixel_format.set_index1lsb
			create {GAME_TEXTURE_TARGET}l_texture.make (a_renderer, l_pixel_format, 0, 0)
			result := l_texture
		end

end
