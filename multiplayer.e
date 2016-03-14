note
	description: "Class managing multiplayer button."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	MULTIPLAYER

inherit
	BUTTONS

create
	make

feature -- Methods

	on_click(a_window:GAME_WINDOW_RENDERED)
		do
			print("Multiplayer")
		end

end
