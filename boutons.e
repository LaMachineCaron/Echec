note
	description: "Classe abstraite pour les boutons."
	author: "Alexandre Caron"
	date: "02 février 2016"

deferred class
	BOUTONS

inherit
	DRAWABLE
	GAME_TEXTURE
		rename
			make as make_texture
		end

feature {NONE}

	make(a_window: GAME_RENDERER; a_image_file: STRING)
		local
			l_image:IMG_IMAGE_FILE
			l_x:INTEGER
			l_y:INTEGER
		do
			has_error := False
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image(a_window, l_image)
				end

			end
		end

feature
	-- Variables

	position_x:INTEGER
	position_y:INTEGER

	set_positions (a_position_x:INTEGER; a_position_y:INTEGER)
		do
			position_x:= a_position_x
			position_y:= a_position_y
		end

end
