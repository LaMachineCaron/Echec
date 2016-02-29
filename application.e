note
	description : "Echec application root class"
	date        : "$Date$"
	revision    : "$Revision$"

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
			-- Run application.
		local
			l_menu: detachable MENU_ENGINE

		do
			game_library.enable_video -- Enable video functinalities
			audio_library.enable_sound
			audio_library.launch_in_thread

			create l_menu.make -- Launch the main loop
			l_menu := Void

			game_library.quit_library -- Clear the library before quiting
			audio_library.stop_thread
			audio_library.quit_library
		end

feature -- Access



end
