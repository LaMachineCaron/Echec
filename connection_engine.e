note
	description: "Engine managing the host feature."
	author: "Alexandre Caron"
	date: "26 April 2016"

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
			-- If the next menu to be used is the last one.
	thread:detachable HOSTING_THREAD
			-- The thread that wait for a connection.
	is_play: BOOLEAN
			-- If the next `engine' to be launch is the game.
	socket:detachable NETWORK_STREAM_SOCKET
			-- The socket that the `thread' will hve created.

feature{NONE}	-- Private Methods

	mouse_pressed(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- When the user click.
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
			-- At every frames
		do
			if (a_timestamp \\ 80) = 0 then
				redraw (a_timestamp)
			end
			if attached thread as la_thread then
					if la_thread.job_done then
					la_thread.join
					print("Connection exectuée!%N")
					start_game
				end
			end
		end

	start_game
			-- Set the next `engine' to be the game.
		do
			if attached thread as la_thread then
				if attached la_thread.socket as la_socket then
					socket := la_socket
				end
				la_thread.stop_thread
				la_thread.main_socket.close
				la_thread.join
			end
			game_library.clear_all_events
			window.clear_events
			window.renderer.clear
			game_library.stop
			is_play := True
		end

	return_from_menu
			-- Return to the last menu
		do
			if attached thread as la_thread then
				la_thread.stop_thread
				la_thread.main_socket.close
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
			create l_return.make (factory.return_button, (background.width // 2) - (factory.return_button.width //2), 500, agent return_from_menu)
			textures.extend (background)
			textures.extend (l_return)
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

	redraw (a_timestamp: NATURAL_32)
			-- Redraw the animation
		local
			l_part: INTEGER
		do
			draw_all
			l_part := (a_timestamp.to_integer_32 \\ 8)
			window.renderer.draw_sub_texture (factory.loading, l_part * 50, 0, 50, factory.loading.height, (background.width // 2) - 25, 425)
			window.renderer.present
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
