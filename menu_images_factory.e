note
	description: "Classe qui crée les images pour les pièces."
	author: "Alexandre Caron"
	date: "01-mars-2016"

class
	MENU_IMAGES_FACTORY

inherit
	IMAGES_FACTORY

create
	make

feature{NONE} -- Initialization

	make(a_renderer:GAME_RENDERER)
		do
			solo_button := set_texture(a_renderer, "./Ressources/button_solo.png")
			multiplayer_button := set_texture(a_renderer, "./Ressources/multiplayer_button.png")
		end

feature -- Attributs

	solo_button:GAME_TEXTURE
	multiplayer_button:GAME_TEXTURE

end
