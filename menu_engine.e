note
	description: "Class that manage menus functionalities."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	MENU_ENGINE

inherit
	ENGINES
		redefine
			start
		end

create
	make

feature{NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
			-- Create the window and the game menu.
		do
			window := a_window
			factory := a_factory
			init_ressources
		end

feature

	is_next_single:BOOLEAN
			-- If the `game_engine' is the next to lauch.
	is_next_multiplayer:BOOLEAN
			-- If the `multiplayer_menu_engine' is the next to lauch.

feature{NONE} -- Private Methods

	start_solo
			-- When the solo `Button' is clicked.
		do
			game_library.clear_all_events
			window.renderer.clear
			game_library.stop
			is_next_single := True
		end

	start_multiplayer
			-- When the multiplayer `Button' is clicked.
		do
			game_library.clear_all_events
			window.renderer.clear
			game_library.stop
			is_next_multiplayer := True
		end

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- When the mouse is pressed, it does the button.on_click action.
		do
			click_sound.play_once
			across textures as la_texture loop
				if cursor_hover_sprite(a_mouse_state, la_texture.item) then
					if attached {BUTTON} la_texture.item as la_bouton then
						la_bouton.on_click
					end
				end
			end
		end

	cursor_hover_sprite(a_mouse_stat: GAME_MOUSE_BUTTON_PRESSED_STATE; a_sprite:DRAWABLE):BOOLEAN
			-- Tells if the cursor is hover a button.
		do
			Result := False
			if (a_mouse_stat.x > a_sprite.x) and (a_mouse_stat.x < a_sprite.x + a_sprite.width) then
				if (a_mouse_stat.y > a_sprite.y) and (a_mouse_stat.y < a_sprite.y + a_sprite.height) then
					Result := True
				end
			end
		end

feature -- Publics Methods

	init_ressources
			-- Initialize every ressources used for this menu.
		local
			l_solo:BUTTON
			l_multiplayer:BUTTON
		do
			create background.make (factory.menu_background)
			create {LINKED_LIST[DRAWABLE]} textures.make
			click_sound := factory.click_sound
			textures.extend (background)
			create l_solo.make (factory.solo_button, 150, 450, agent start_solo)
			create l_multiplayer.make (factory.multiplayer_button, 450, 450, agent start_multiplayer)
			textures.extend (l_solo)
			textures.extend (l_multiplayer)
		end

	set_agents
			-- Set the agents.
		do
			game_library.quit_signal_actions.extend(agent quit)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

	start
			-- <Precursor>
		do
			is_next_single := False
			is_next_multiplayer := False
			Precursor
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
