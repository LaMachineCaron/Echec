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
			l_environment:EXECUTION_ENVIRONMENT
		do
			create l_environment
			audio_library.sources_add
			source:=audio_library.last_source_added
			create sound.make("./Ressources/click.ogg")
			sound.open
		end
feature -- Attributs

	sound: AUDIO_SOUND_FILE
	source: AUDIO_SOURCE

feature -- Methods

	play
		do
			if sound.is_open then
				source.queue_sound (sound)
				source.play
			end
		end
end
