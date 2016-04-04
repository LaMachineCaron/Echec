note
	description: "Abstract class for engines."
	author: "Alexandre Caron"
	date: "30 March 2016"

deferred class
	ENGINES

feature --Attributs

	background: BACKGROUND
	factory: RESSOURCES_FACTORY
	click_sound: AUDIO

invariant
	valid_background_position: background.x = 0 and background.y = 0
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
