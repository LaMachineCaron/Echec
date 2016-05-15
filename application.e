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
	TEXT_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Create the `Current'
		local
			l_master: detachable ENGINE_MASTER

		do
			game_library.enable_video -- Enable video functinalities
			text_library.enable_text
			audio_library.enable_sound
			audio_library.launch_in_thread

			create l_master.make -- Launch the main loop
			l_master := Void

			game_library.clear_all_events
			game_library.quit_library -- Clear the library before quiting
			text_library.quit_library
			audio_library.stop_thread
			audio_library.quit_library
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
