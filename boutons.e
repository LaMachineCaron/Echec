note
	description: "Classe abstraite pour les boutons."
	author: "Alexandre Caron"
	date: "02 février 2016"

deferred class
	BOUTONS

inherit
	DRAWABLE

feature

	on_click(a_window:GAME_WINDOW_RENDERED)
		deferred
		end

end
