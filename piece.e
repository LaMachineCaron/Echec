note
	description: "Classe abstraite pour les pi�ces"
	author: "Alexandre Caron"
	date: "02 f�vrier 2016"

deferred class
	PIECE

inherit
	DRAWABLE
		rename make as
			make_drawable
		end

feature {NONE} -- Initialization

	make(a_renderer:GAME_RENDERER; a_image_file:STRING; a_white_team:BOOLEAN)
		local
			l_image:IMG_IMAGE_FILE
		do
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create texture.make_from_image (a_renderer, l_image)
					set_dimensions(68,68)
					set_first_move
					set_team(a_white_team)
				else
					default_image(a_renderer)
				end
			else
				default_image(a_renderer)
			end
		end

feature -- Attributs

	first_move: BOOLEAN
	is_white: BOOLEAN -- l'�quipe
	is_black: BOOLEAN -- l'�quipe

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
