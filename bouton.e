note
	description: "Summary description for {BOUTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIJOUEUR

inherit
	BOUTONS

create
	make

feature

	on_click(a_window:GAME_WINDOW_RENDERED)
		do
			print("Multijoueur")
		end

end
