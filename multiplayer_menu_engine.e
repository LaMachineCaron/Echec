note
	description: "Class managing the multiplayer menu."
	author: "Alexandre Caron"
	date: "30 March 2016"

class
	MULTIPLAYER_MENU_ENGINE

inherit
	ENGINES

create
	make

feature {NONE} -- Initialization

	make(a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
	-- Create the multiplayer menu.
		do
			window := a_window
			factory := a_factory
			init_ressources
			set_agents
		end

feature -- Attributs

	textbox: TEXTBOX -- For the player to enter a server ip.

feature -- Methods

	set_agents
	-- Set every agent for this menu.
		do
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			game_library.iteration_actions.extend (agent on_iteration)
			window.text_input_actions.extend (agent text_input)
			window.key_pressed_actions.extend (agent key_pressed)
			window.expose_actions.extend (agent (timestamp: NATURAL_32) do draw_all end)
		end

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
			if cursor_over_textbox(a_mouse_state) then
				textbox.is_selected := True
				window.start_text_input
			else
				textbox.is_selected := False
				window.stop_text_input
			end
		end

	cursor_over_textbox(a_mouse_state:GAME_MOUSE_BUTTON_PRESSED_STATE):BOOLEAN
	-- Return true is the cursor is over the textbox.
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

	init_ressources
	-- Initialize every ressources for this menu.
		local
			l_ip_text:TEXT
			l_return:RETURN
		do
			create {LINKED_LIST[DRAWABLE]} textures.make
			create background.make (factory.menu_background)
			create l_ip_text.make ("Server IP", factory, window.renderer)
			create textbox.make(350, 450, factory.ubuntu_font.text_dimension ("000.000.000.000").width + 10, 25, 5)
			--create l_return.make_with_position (factory.return_button, 100, 100)
			textures.extend (background)
			--textures.extend (l_return)
			draw_all
			click_sound := factory.click_sound
			draw_textbox
			window.renderer.draw_texture(l_ip_text.texture, textbox.info.x - l_ip_text.width - 5, textbox.info.y + textbox.info.height // 2 - l_ip_text.height // 2)
			window.renderer.draw_filled_rectangle (textbox.info.x, textbox.info.y, textbox.info.width, textbox.info.height)
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
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
