note
	description: "Text to be draw."
	author: "Alexandre"
	date: "01 April 2016"

class
	TEXT

inherit
	DRAWABLE
		rename make as
			make_drawable
		end

create
	make

feature -- Initialization

	make(a_text:READABLE_STRING_GENERAL; a_factory:RESSOURCES_FACTORY; a_renderer:GAME_RENDERER)
		local
			l_text_surface: TEXT_SURFACE_BLENDED
		do
			text := a_text
			create l_text_surface.make(text, a_factory.ubuntu_font, a_factory.black)
			if l_text_surface.is_open then
				create texture.make_from_surface(a_renderer, l_text_surface)
			else
				texture := a_factory.default_image (a_renderer)
			end
		end

feature -- Attributs

	text:READABLE_STRING_GENERAL -- The text to be displayed.

end