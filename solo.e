note
	description: "Classe qui gère le bouton solo."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	SOLO

inherit
	BUTTONS

create
	make

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED)
		local
			l_game_engine:GAME_ENGINE
		do
			create l_game_engine.make(a_window)
		end

end
