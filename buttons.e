note
	description: "Classe abstraite pour les boutons."
	author: "Alexandre Caron"
	date: "02 f�vrier 2016"

deferred class
	BUTTONS

inherit
	DRAWABLE

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED)
		deferred
		end

end