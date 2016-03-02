note
	description: "Classe qui gère les fonctionnalités du menu."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	MENU_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature{NONE} -- Initialization

	make
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
			l_icon_image:GAME_IMAGE_BMP_FILE
			l_multijoueur:MULTIPLAYER
			l_solo:SOLO
			l_sprites: ARRAYED_LIST[DRAWABLE]
			l_music:MUSIC
			l_sound:SOUND
			l_menu_images:MENU_IMAGES_FACTORY
		do
			create l_window_builder
			l_window_builder.set_dimension(800, 600)
			l_window_builder.set_title("Jeu Échec")
			create l_icon_image.make("./Ressources/icon.bmp")-- Ne fonctionne pas.
			l_window := l_window_builder.generate_window
			create l_menu_images.make (l_window.renderer)
			create l_sprites.make(1)
			create l_multijoueur.make(l_menu_images.multiplayer_button, 180, 43)
			l_sprites.extend (l_multijoueur)
			create l_solo.make(l_menu_images.solo_button, 180, 43)
			l_sprites.extend (l_solo)
			l_multijoueur.set_positions(320, 350)
			l_solo.set_positions(320, 250)
			l_sprites.do_all (agent draw_button(l_window.renderer, ?))
			create l_music.make
			create l_sound.make
			l_window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, l_window, l_sprites, l_sound))
			set_agents
			l_window.update
			game_library.launch
		end

feature {NONE}

	on_iteration(a_timestamp:NATURAL; a_window:GAME_WINDOW; a_music:MUSIC)
		do
			a_music.audio_library.update
			a_window.update
		end

	set_agents
		do
			game_library.quit_signal_actions.extend(agent (a_timestamp:NATURAL_32) do game_library.stop end)
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_sprites:ARRAYED_LIST[DRAWABLE]; a_sound:SOUND)
		do
			a_sound.play
			across a_sprites as la_sprites loop
				if cursor_over_sprite(mouse_state, la_sprites.item) then
					if attached {BUTTONS} la_sprites.item as la_bouton then
						la_bouton.on_click(a_window)
					end
				end
			end

		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:DRAWABLE):BOOLEAN
		local
			l_over:BOOLEAN
		do
			l_over:= False
			if (a_mouse_stat.x > a_sprite.x) and (a_mouse_stat.x < a_sprite.x + a_sprite.dimension_x) then
				if (a_mouse_stat.y > a_sprite.y) and (a_mouse_stat.y < a_sprite.y + a_sprite.dimension_y) then
					l_over := True
				end
			end
			Result := l_over
		end

	draw(renderer: GAME_RENDERER)
		do
			renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			renderer.draw_line (100, 100, 425, 260)
		end

	draw_button(a_window:GAME_RENDERER; a_sprites:DRAWABLE)
		do
			a_window.draw_texture (a_sprites.texture, a_sprites.x, a_sprites.y)
		end

end
