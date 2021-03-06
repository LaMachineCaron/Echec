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

	background: BACKGROUND
			-- The engine background
	factory: RESSOURCES_FACTORY
			-- The ressource factory.
	click_sound: AUDIO
			-- The sound of the click.
	textures:LIST[DRAWABLE]
			-- List of {DRAWABLE} to be draw.
	window: GAME_WINDOW_RENDERED
			-- The `Current' window.
	must_quit:BOOLEAN
			-- True when the user want to quit the program.

feature -- Methods

	set_agents
			-- Set agents for the `Current'
		deferred
		end

	draw_all
			-- Draw every `Drawable' in `textures' on `window'.
		do
			across textures as la_texture loop
				window.renderer.draw_texture(la_texture.item.texture, la_texture.item.x, la_texture.item.y)
			end
		end

	start
			-- starts the `Current'.
		do
			must_quit := False
			set_agents
			draw_all
			window.update
			game_library.launch
		end

	quit(a_timestamp: NATURAL_32)
			-- When the user want to close the program.
		do
			must_quit := True
			game_library.stop
		end

	cursor_hover_texture(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_texture:DRAWABLE):BOOLEAN
			-- Tells if the cursor is hover a texture.
		local
			l_hover:BOOLEAN
		do
			l_hover:= False
			if (a_mouse_stat.x > a_texture.x) and (a_mouse_stat.x < a_texture.x + a_texture.width) then
				if (a_mouse_stat.y > a_texture.y) and (a_mouse_stat.y < a_texture.y + a_texture.height) then
					l_hover := True
				end
			end
			Result := l_hover
		end

invariant
	valid_background_position: background.x = 0 and background.y = 0

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
