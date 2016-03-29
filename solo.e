note
	description: "Class managing solo button."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	SOLO

inherit
	BUTTONS

create
	make

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED)
	-- Create the game engine.
		local
			l_game_engine:GAME_ENGINE
		do
			create l_game_engine.make(a_window)
		end

end
