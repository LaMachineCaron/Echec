note
	description: "Class that manage menus functionalities."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	MENU_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED
	ENGINES

create
	make

feature{NONE} -- Initialization

	make
	-- Create the window and the game menu.
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_window:GAME_WINDOW_RENDERED
			l_multijoueur:MULTIPLAYER
			l_solo:SOLO
			l_sprites: ARRAYED_LIST[DRAWABLE]
		do
			create l_window_builder
			l_window_builder.set_dimension(800, 600)
			l_window_builder.set_title("Jeu Échec")
			l_window := l_window_builder.generate_window
			create factory.make (l_window.renderer)
			click_sound := factory.click_sound
			create background.make(factory.menu_background)
			l_window.renderer.draw_texture (background.texture, background.x, background.y)
			create l_sprites.make(1)
			create l_multijoueur.make(factory.multiplayer_button)
			l_sprites.extend (l_multijoueur)
			create l_solo.make(factory.solo_button)
			l_sprites.extend (l_solo)
			l_multijoueur.set_positions(450, 450)
			l_solo.set_positions(150, 450)
			l_sprites.do_all (agent draw_button(l_window.renderer, ?))
			factory.main_music.play_loop
			l_window.mouse_button_pressed_actions.extend(agent mouse_pressed(?, ?, ?, l_window, l_sprites))
			set_agents
			l_window.update
			game_library.launch
		end

feature {NONE}

	set_agents
	-- Set the agents.
		do
			game_library.quit_signal_actions.extend(agent (a_timestamp:NATURAL_32) do game_library.stop end)
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED; a_sprites:ARRAYED_LIST[DRAWABLE])
	-- When the mouse is pressed, it does the button.on_click action.
		do
			click_sound.play_once
			across a_sprites as la_sprites loop
				if cursor_over_sprite(mouse_state, la_sprites.item) then
					if attached {BUTTONS} la_sprites.item as la_bouton then
						la_bouton.on_click(a_window, factory)
					end
				end
			end

		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:DRAWABLE):BOOLEAN
	-- Tells if the cursor is over a sprite.
		local
			l_over:BOOLEAN
		do
			l_over:= False
			if (a_mouse_stat.x > a_sprite.x) and (a_mouse_stat.x < a_sprite.x + a_sprite.width) then
				if (a_mouse_stat.y > a_sprite.y) and (a_mouse_stat.y < a_sprite.y + a_sprite.height) then
					l_over := True
				end
			end
			Result := l_over
		end

	draw(renderer: GAME_RENDERER) -- Useless for now. Used for testing.
		do
			renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			renderer.draw_line (100, 100, 425, 260)
		end

	draw_button(a_window:GAME_RENDERER; a_sprites:DRAWABLE)
	-- Draw a drawable.
		do
			a_window.draw_texture (a_sprites.texture, a_sprites.x, a_sprites.y)
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
