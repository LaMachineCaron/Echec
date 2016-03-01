note
	description: "Summary description for {BOUTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLAYER

inherit
	BUTTONS

create
	make

feature

	on_click(a_window:GAME_WINDOW_RENDERED)
		do
			print("Multiplayer")
		end

end
