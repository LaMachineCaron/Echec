note
	description : "Echec application root class"
	author		: "Alexandre Caron"
	date        : "02 february 2016"

class
	APPLICATION

inherit
	AUDIO_LIBRARY_SHARED
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
			l_menu: detachable MENU_ENGINE

		do
			game_library.enable_video -- Enable video functinalities
			audio_library.enable_sound
			audio_library.launch_in_thread

			create l_menu.make -- Launch the main loop
			l_menu := Void

			game_library.clear_all_events
			game_library.quit_library -- Clear the library before quiting
			audio_library.stop_thread
			audio_library.quit_library
		end

end
