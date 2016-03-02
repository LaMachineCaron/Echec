note
	description: "Classe qui va gérer les sons des pièces."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	SOUND

inherit
	AUDIO_LIBRARY_SHARED

create
	make

feature{NONE} -- Initialize

	make
		local
			l_source:AUDIO_SOURCE
			l_sound:AUDIO_SOUND_FILE
			l_environment:EXECUTION_ENVIRONMENT
		do
			create l_environment
			audio_library.sources_add
			l_source:=audio_library.last_source_added
			create l_sound.make("./Ressources/click.ogg")
			l_sound.open
			if l_sound.is_open then
				l_source.queue_sound (l_sound)
				l_source.play
			end
		end
end
