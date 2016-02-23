note
	description: "Summary description for {GAME_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature{NONE} -- Constructor

	make

		local
			window_builder:GAME_WINDOW_RENDERED_BUILDER
			window:GAME_WINDOW_RENDERED
			l_icon_image:GAME_IMAGE_BMP_FILE
			l_multijoueur:MULTIJOUEUR
			l_solo:SOLO
			l_sprites: ARRAYED_LIST[DRAWABLE]
			l_music:MUSIC
		do
			create window_builder
			window_builder.set_dimension(800, 600)
			window_builder.set_title("Jeu Échec")
			create l_icon_image.make("./Ressources/icon.bmp")
			window := window_builder.generate_window
			create l_sprites.make(1)
			create l_multijoueur.make(window.renderer, "./Ressources/multiplayer_button.png", 180, 43)
			l_sprites.extend (l_multijoueur)
			create l_solo.make(window.renderer, "./Ressources/button_solo.png", 180, 43)
			l_sprites.extend (l_solo)
			l_multijoueur.set_positions(320, 350)
			l_solo.set_positions(320, 250)
			l_sprites.do_all (agent draw_button(window.renderer, ?))
			window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, window, l_sprites))
			create l_music.make
			game_library.iteration_actions.extend (agent on_iteration(?, window, l_music))
			set_agents
			window.update
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

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_sprites:ARRAYED_LIST[DRAWABLE])
		local
			l_game_engine:GAME_ENGINE
		do
			across a_sprites as la_sprites loop
				if cursor_over_sprite(mouse_state, la_sprites.item) then
					if attached {BOUTONS} la_sprites.item as la_bouton then
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
			if (a_mouse_stat.x > a_sprite.position_x) and (a_mouse_stat.x < a_sprite.position_x + a_sprite.dimension_x) then
				if (a_mouse_stat.y > a_sprite.position_y) and (a_mouse_stat.y < a_sprite.position_y + a_sprite.dimension_y) then
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
			a_window.draw_texture (a_sprites, a_sprites.position_x, a_sprites.position_y)
		end

feature
	--Variables



end
