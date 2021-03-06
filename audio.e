note
	description: "Class managing sound when clicking."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	AUDIO

inherit
	AUDIO_LIBRARY_SHARED

create
	make

feature{NONE} -- Initialize

	make(a_sound_file:STRING)
			-- Create a `sound' with the string passed in argument.
		do
			has_error := False
			audio_library.sources_add
			source:=audio_library.last_source_added
			create sound.make(a_sound_file)
			if sound.is_openable then
				sound.open
			else
				has_error := True
				io.put_string ("Can't open the sound file " + a_sound_file + ".%N")
			end
		end

feature -- Attributs

	has_error: BOOLEAN
			-- True is there's an error.
	sound: AUDIO_SOUND_FILE
			-- The sound to be played.
	source: AUDIO_SOURCE
			-- The source where the sound is.

feature -- Methods

	play_once
			-- play the `sound' once.
		do
			if sound.is_open then
				source.queue_sound (sound)
				source.play
			end
		end

	play_loop
			-- Play the audio in loop.
		do
			if sound.is_open then
				source.queue_sound_infinite_loop (sound)
				source.play
			end
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
