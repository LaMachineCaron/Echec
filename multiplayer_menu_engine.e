note
	description: "Class managing the multiplayer menu."
	author: "Alexandre Caron"
	date: "30 March 2016"

class
	MULTIPLAYER_MENU_ENGINE

inherit
	ENGINES
		redefine
			start,
			draw_all
		end

create
	make

feature {NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
			-- Create the multiplayer menu.
		do
			window := a_window
			factory := a_factory
			init_ressources
		end

feature -- Attributs

	textbox: TEXTBOX
			-- For the player to enter a server ip.
	is_return: BOOLEAN
			-- If the next engine is the last one.
	is_host: BOOLEAN
			-- If the next engine is `Connection_engine'.


feature{NONE} -- Private Methods

	key_pressed(a_timestamp: NATURAL_32; a_key_state: GAME_KEY_STATE)
			-- When a key is being pressed.
		do
			if a_key_state.is_backspace and textbox.text.count > 0 then
				textbox.sub_text
			end
		end

	text_input(a_timestamp:NATURAL_32; a_text:STRING_32)
			-- When entring text in a `textbox'.
		do
			if textbox.is_selected and textbox.text.count < 15  then
				textbox.add_text(a_text)
			end
		end

	on_iteration(a_timestamp: NATURAL_32)
			-- At every frames
		do
			draw_textbox
			if ((a_timestamp // 500) \\ 2 = 1) then -- True every sec.
				textbox.flashing_cursor (window, factory)
			end
			draw_textbox_text
			window.update
		end

	mouse_pressed(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- When the mouse button is pressed.
		do
			factory.click_sound.play_once
			if cursor_hover_textbox(a_mouse_state) then
				textbox.is_selected := True
				window.start_text_input
				window.text_input_actions.extend (agent text_input)
			else
				if game_library.events_controller.is_text_input_event_enable then
					window.text_input_actions.wipe_out
				end
				window.stop_text_input
				textbox.is_selected := False
				across textures as la_texture loop
					if attached {BUTTON} la_texture.item as la_button then
						if cursor_hover_texture(a_mouse_state, la_button) then
							la_button.on_click
						end
					end
				end
			end
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

	cursor_hover_textbox(a_mouse_state:GAME_MOUSE_BUTTON_PRESSED_STATE):BOOLEAN
			-- Return true is the cursor is hover the textbox.
		local
			l_valid: BOOLEAN
		do
			l_valid := False
			if (a_mouse_state.x >= textbox.info.x and a_mouse_state.x <= textbox.info.x + textbox.info.width) then
				if a_mouse_state.y >= textbox.info.y and a_mouse_state.y <= textbox.info.y + textbox.info.height then
					l_valid := True
				end
			end
			Result := l_valid
		end

	draw_textbox
			-- Draw the white textbox.
		do
			window.renderer.drawing_color := factory.white
			window.renderer.draw_filled_rectangle (textbox.info.x, textbox.info.y, textbox.info.width, textbox.info.height)
		end

	draw_textbox_text
			-- Draw the textbox.
		local
			l_text: TEXT
		do
			create l_text.make (textbox.text, factory, window.renderer)
			if l_text.width >= textbox.info.width - textbox.info.padding then
				window.renderer.draw_sub_texture (l_text.texture, l_text.width - textbox.info.width + textbox.info.padding, 0, textbox.info.width - textbox.info.padding, l_text.height, textbox.info.x + textbox.info.padding, textbox.info.y + textbox.info.height // 2 - l_text.height // 2)
			else
				window.renderer.draw_texture (l_text.texture, textbox.info.x + textbox.info.padding, textbox.info.y + textbox.info.height // 2 - l_text.height // 2)
			end
		end

	join
			-- Create a connexion with the ip in the `Textbox'.
		local
			l_thread: JOIN_THREAD
		do
			create l_thread.make (textbox.text)
			l_thread.launch
		end

	host
			-- Lauch the engine that wait for a connection.
		do
			game_library.clear_all_events
			window.renderer.clear
			game_library.stop
			is_host := True
		end

	return_from_menu
			-- Return to the last menu.
		do
			textbox.clear
			game_library.clear_all_events
			window.clear_events
			window.renderer.clear
			game_library.stop
			is_return := True
		end

feature -- Public Methods

	start
				--<Precursor>
		do
			is_return := False
			is_host := False
			Precursor
		end

	set_agents
			-- Set every agent for this menu.
		do
			game_library.quit_signal_actions.extend (agent quit)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			game_library.iteration_actions.extend (agent on_iteration)
			window.key_pressed_actions.extend (agent key_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

	init_ressources
			-- Initialize every ressources for this menu.
		local
			l_ip_text: TEXT
			l_return: BUTTON
			l_join: BUTTON
			l_host: BUTTON
		do
			create {LINKED_LIST[DRAWABLE]} textures.make
			create background.make (factory.menu_background)
			create l_ip_text.make ("Server IP", factory, window.renderer)
			create textbox.make(350, 400, factory.ubuntu_font.text_dimension ("000.000.000.000").width + 10, 25, 5)
			click_sound := factory.click_sound
			create l_return.make (factory.return_button, 100, 100, agent return_from_menu)
			create l_join.make (factory.join_button, 450, 450, agent join)
			create l_host.make (factory.host_button, 150, 450, agent host)
			textures.extend (background)
			textures.extend(l_join)
			textures.extend (l_host)
			textures.extend (l_return)
		end

	draw_all
			--<Precursor>
		do
			Precursor
			draw_textbox
			draw_textbox_text
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
