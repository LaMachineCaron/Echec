note
	description: "Summary description for {MUSIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MUSIC
inherit
	AUDIO_LIBRARY_SHARED

create
	make

feature{NONE}

	make
		local
			l_source:AUDIO_SOURCE
			l_music:AUDIO_SOUND_FILE
			l_environment:EXECUTION_ENVIRONMENT
		do
			create l_environment
			audio_library.sources_add
			l_source:=audio_library.last_source_added
			create l_music.make("./Ressources/music.wav")
			l_music.open
			if l_music.is_open then
				l_source.queue_sound_infinite_loop (l_music)
				l_source.play
				audio_library.update
			end
		end
end
