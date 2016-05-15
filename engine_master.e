note
	description: "Manage the engine."
	author: "Alexandre Caron"
	date: "05 April 2016"

class
	ENGINE_MASTER

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature -- Attributs

	singleplayer:GAME_ENGINE_SINGLEPLAYER
			-- A single player engine
	multiplayer_local:GAME_ENGINE_MULTIPLAYER_LOCAL
			-- Engine for playing multiplayer on the same computer
	menu_engine:MENU_ENGINE
			-- Engine that manage the main menu
	multiplayer_menu_engine:MULTIPLAYER_MENU_ENGINE
			-- Engine that manage the menu for multiplayer
	waiting_connection: CONNECTION_ENGINE
			-- Engine that wait for a connection to start a multiplayer game
	factory: RESSOURCES_FACTORY
			-- The factory containing every ressources of the game
	window:GAME_WINDOW_RENDERED
			-- The window for the whole game
	current_engine:ENGINES
			-- The engine currently running
	last_engine:detachable ENGINES
			-- Last engine used
	must_quit:BOOLEAN
			-- True if the game needs to be closed

feature {NONE} -- Initialization

	make
			-- Create the `Current'.
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
		do
			create l_window_builder
			l_window_builder.set_dimension(800, 600)
			l_window_builder.set_title("Jeu Échec")
			window := l_window_builder.generate_window
			create factory.make(window.renderer)
			create menu_engine.make (window, factory)
			create multiplayer_menu_engine.make(window, factory)
			create singleplayer.make(window, factory)
			create multiplayer_local.make(window, factory)
			create waiting_connection.make(window, factory)
			must_quit := False
			current_engine := menu_engine
			factory.main_music.play_loop
			from
			until current_engine.must_quit
			loop
				start
			end
		end

feature -- Methods

	start
			-- Start the program with the current engine.
		local
			l_multiplayer_game: GAME_ENGINE_MULTIPLAYER_NETWORK
		do

			current_engine.start
			if attached {MENU_ENGINE} current_engine as la_menu then
				if la_menu.is_next_single then
					last_engine := current_engine
					current_engine := singleplayer
				elseif la_menu.is_next_multiplayer then
					last_engine := current_engine
					current_engine := multiplayer_menu_engine
				elseif la_menu.is_next_local then
					last_engine := current_engine
					current_engine := multiplayer_local
				end
			elseif attached {MULTIPLAYER_MENU_ENGINE} current_engine as la_menu then
				if la_menu.is_return then
					if attached last_engine as la_last_engine then
						current_engine := menu_engine
						last_engine := Void
					end
				elseif la_menu.is_host then
					last_engine := current_engine
					current_engine := waiting_connection
				elseif la_menu.is_join then
					if attached la_menu.socket as la_socket then
						create l_multiplayer_game.make_multiplayer_network (window, factory, la_socket, False)
						current_engine := l_multiplayer_game
					end
				end

			elseif attached {CONNECTION_ENGINE} current_engine as la_menu then
				if la_menu.is_return then
					if attached last_engine as la_last_engine then
						current_engine := la_last_engine
					end
				elseif la_menu.is_play then
					if attached la_menu.socket as la_socket then
						create l_multiplayer_game.make_multiplayer_network (window, factory, la_socket, True)
						current_engine := l_multiplayer_game
					end
				end
			end
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
