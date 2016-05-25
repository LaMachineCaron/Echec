note
	description: "Manage the engine."
	author: "Alexandre Caron"
	date: "05 April 2016"

class
	ENGINE_MASTER

inherit
	GAME_LIBRARY_SHARED

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
			create singleplayer.make_multiplayer(window, factory, True)
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
		do

			current_engine.start
			if attached {MENU_ENGINE} current_engine as la_menu then
				currently_menu_engine (la_menu)
			elseif attached {MULTIPLAYER_MENU_ENGINE} current_engine as la_menu then
				currently_multiplayer_menu_engine (la_menu)
			elseif attached {CONNECTION_ENGINE} current_engine as la_menu then
				currently_connection_engine (la_menu)
			elseif attached {GAME_ENGINE_MULTIPLAYER_LOCAL} current_engine as la_menu then
				currently_game_engine (la_menu)
			end
		end

feature{NONE} -- Private Methods

	currently_game_engine (a_menu: GAME_ENGINE_MULTIPLAYER_LOCAL)
			-- Manage the next engine for {game_engine_multiplayer_local}
		do
			if a_menu.is_quitting then
				last_engine := Void
				current_engine := menu_engine
			end
		end

	currently_menu_engine (a_menu: MENU_ENGINE)
			-- Manage the next engine for {menu_engine}.
		do
			if a_menu.is_next_single then
					last_engine := current_engine
					create singleplayer.make_multiplayer (window, factory, True)
					current_engine := singleplayer
				elseif a_menu.is_next_multiplayer then
					last_engine := current_engine
					current_engine := multiplayer_menu_engine
				elseif a_menu.is_next_local then
					last_engine := current_engine
					create multiplayer_local.make (window, factory)
					current_engine := multiplayer_local
				end
		end

	currently_multiplayer_menu_engine (a_menu: MULTIPLAYER_MENU_ENGINE)
			-- Manage the next engine for {multiplayer_menu_engine}
		local
			l_multiplayer_game: GAME_ENGINE_MULTIPLAYER_NETWORK
		do
			if a_menu.is_return then
				if attached last_engine as la_last_engine then
					current_engine := menu_engine
					last_engine := Void
				end
				elseif a_menu.is_host then
					last_engine := current_engine
					current_engine := waiting_connection
				elseif a_menu.is_join then
				if attached a_menu.socket as la_socket then
					create l_multiplayer_game.make_multiplayer_network (window, factory, la_socket, False)
					current_engine := l_multiplayer_game
				end
			end
		end

	currently_connection_engine (a_menu: CONNECTION_ENGINE)
			-- Manage the next engine for {connection_engine}
		local
			l_multiplayer_game: GAME_ENGINE_MULTIPLAYER_NETWORK
		do
			if a_menu.is_return then
				if attached last_engine as la_last_engine then
					current_engine := la_last_engine
				end
			elseif a_menu.is_play then
				if attached a_menu.socket as la_socket then
					create l_multiplayer_game.make_multiplayer_network (window, factory, la_socket, True)
					current_engine := l_multiplayer_game
				end
			end
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
