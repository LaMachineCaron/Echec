note
	description: "Summary description for {CONNECTION_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONNECTION_ENGINE

inherit
	ENGINES
		redefine
			start
		end

create
	make

feature {NONE} -- Initialization

	make (a_window:GAME_WINDOW_RENDERED; a_factory:RESSOURCES_FACTORY)
		do
			window := a_window
			factory := a_factory
			init_ressources
		end

feature -- Public Attributs

	is_return: BOOLEAN
	thread: detachable CONNECTOR_THREAD
			-- The thread that wait for a connection.

feature{NONE}	-- Private Methods

	mouse_pressed(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
		do
			click_sound.play_once
			across textures as la_texture loop
					if attached {BUTTON} la_texture.item as la_button then
						if cursor_hover_texture(a_mouse_state, la_button) then
							la_button.on_click
						end
					end
				end
		end

	on_iteration(a_timestamp: NATURAL_32)
		do
			if attached thread as la_thread then
				if la_thread.job_done then
					la_thread.join
					print("Connection exectuée!%N")
				end
			end
		end

	return_from_menu
			-- Return to the last menu
		do
			if attached thread as la_thread then
				la_thread.stop_thread
				la_thread.socket.close
				la_thread.join
			end
			game_library.clear_all_events
			window.clear_events
			window.renderer.clear
			game_library.stop
			is_return := True
		end

	init_ressources
			-- Initialize every ressources for the `Current'.
		local
			l_return: BUTTON
		do
			click_sound := factory.click_sound
			create {LINKED_LIST[DRAWABLE]} textures.make
			create background.make (factory.waiting_for_connection)
			create l_return.make (factory.return_button, (background.width // 2) - (factory.return_button.width //2), 450, agent return_from_menu)
			textures.extend (background)
			textures.extend (l_return)
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

feature	-- Public Methods

	set_agents
			--<Precursor>
		do
			game_library.quit_signal_actions.extend (agent quit)
			window.mouse_button_pressed_actions.extend(agent mouse_pressed)
			game_library.iteration_actions.extend (agent on_iteration)
		end

	start
			--<Precursor>
		do
			is_return := False
			create thread.make
			if attached thread as la_thread then
				la_thread.launch
			end
			Precursor
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
