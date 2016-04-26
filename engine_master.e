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

	game_engine:GAME_ENGINE
	menu_engine:MENU_ENGINE
	multiplayer_menu_engine:MULTIPLAYER_MENU_ENGINE
	waiting_connection: CONNECTION_ENGINE
	factory: RESSOURCES_FACTORY
	window:GAME_WINDOW_RENDERED
	current_engine:ENGINES
	last_engine:detachable ENGINES
	must_quit:BOOLEAN
	--thread: NETWORK_THREAD

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
			create game_engine.make(window, factory)
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
				if la_menu.is_next_single then
					last_engine := current_engine
					current_engine := game_engine
				elseif la_menu.is_next_multiplayer then
					last_engine := current_engine
					current_engine := multiplayer_menu_engine
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
				end
			elseif attached {CONNECTION_ENGINE} current_engine as la_menu then
				if la_menu.is_return then
					if attached last_engine as la_last_engine then
						current_engine := multiplayer_menu_engine
					end
				end
			end
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
