note
	description: "Abstract class for engines."
	author: "Alexandre Caron"
	date: "30 March 2016"

deferred class
	ENGINES

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

feature -- Attributs

	background: BACKGROUND -- The engine background
	factory: RESSOURCES_FACTORY -- The ressource factory.
	click_sound: AUDIO -- The `Sound' of the click.
	textures:LIST[DRAWABLE] -- List of `Drawable' to be draw.
	window: GAME_WINDOW_RENDERED -- The `Current' window.

feature -- Methods

	draw_all
	-- Draw every `Drawable' in `textures' on `window'.
		do
			across textures as la_texture loop
				window.renderer.draw_texture(la_texture.item.texture, la_texture.item.x, la_texture.item.y)
			end
			window.update
		end

invariant
	valid_background_position: background.x = 0 and background.y = 0
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
