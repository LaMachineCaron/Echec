note
	description: "Class that manage menus functionalities."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	MENU_ENGINE

inherit
	ENGINES

create
	make

feature{NONE} -- Initialization

	make
	-- Create the window and the game menu.
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
		do
			create l_window_builder
			l_window_builder.set_dimension(800, 600)
			l_window_builder.set_title("Jeu Échec")
			window := l_window_builder.generate_window
			create factory.make (window.renderer)
			init_ressources
			factory.main_music.play_loop
			set_agents
			draw_all
			game_library.launch
		end

feature {NONE}

	init_ressources
	-- Initialize every ressources used for this menu.
		local
			l_multiplayer: MULTIPLAYER
			l_solo: SOLO
		do
			create background.make (factory.menu_background)
			create l_multiplayer.make_with_position (factory.multiplayer_button, 450, 450)
			create l_solo.make_with_position (factory.solo_button, 150, 450)
			create {LINKED_LIST[DRAWABLE]} textures.make
			click_sound := factory.click_sound
			textures.extend (background)
			textures.extend (l_multiplayer)
			textures.extend (l_solo)
		end

	set_agents
	-- Set the agents.
		do
			game_library.quit_signal_actions.extend(agent (a_timestamp:NATURAL_32) do game_library.stop end)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

	mouse_pressed (timestamp: NATURAL_32; mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; nb_clicks: NATURAL_8)
	-- When the mouse is pressed, it does the button.on_click action.
		do
			click_sound.play_once
			across textures as la_texture loop
				if cursor_over_sprite(mouse_state, la_texture.item) then
					if attached {BUTTON} la_texture.item as la_bouton then
						window.clear_events
						window.renderer.clear
						la_bouton.on_click(window, factory)
						-- Reset evenement
					end
				end
			end
		end

	cursor_over_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:DRAWABLE):BOOLEAN
	-- Tells if the cursor is over a button.
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

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
