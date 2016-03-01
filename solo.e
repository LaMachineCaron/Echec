note
	description: "Summary description for {SOLO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOLO

inherit
	BUTTONS

create
	make

feature

	on_click(a_window:GAME_WINDOW_RENDERED)
		local
			l_game_engine:GAME_ENGINE
		do
			create l_game_engine.make(a_window)
		end

end
