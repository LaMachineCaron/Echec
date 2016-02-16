note
	description : "Echec application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a: CAVALIER
			b: FOU
			c: PION
			d: REINE
			e: ROI
			f: TOUR
			g: SERVEUR
			menu: detachable MENU_ENGINE

		do
			game_library.enable_video -- Enable video functinalities
			create menu.make -- Launch the main loop
			menu := Void
			game_library.quit_library -- Clear the library before quiting
		end

feature -- Access



end
