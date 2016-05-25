note
	description: "Abstract class for game_engine with 2 players."
	author: "Alexandre Caron"
	date: "26 April 2016"

deferred class
	GAME_ENGINE_NON_LOCAL

inherit
	GAME_ENGINE_MULTIPLAYER_LOCAL
		redefine
			mouse_pressed
		end

feature{NONE} -- Initialization

	make_multiplayer(a_window:GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY; a_is_white: BOOLEAN)
			--<Precursor>
		do
			is_player_white := a_is_white
			turn_is_done := false
			make(a_window, a_factory)
		end

feature -- Attributs

	is_player_white: BOOLEAN
			-- If the player currently playing is white.
	turn_is_done: BOOLEAN
			-- True when the turn is completed		

feature {NONE} -- Private Methods

	mouse_pressed (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- <Precursor>
		do
			if game_is_over then
				mouse_pressed_when_game_over (a_timestamp, a_mouse_state, a_nb_clicks)
			else
				if is_white_turn = is_player_white then
					Precursor(a_timestamp, a_mouse_state,a_nb_clicks)
				end
			end

		end

	other_player_turn
			-- Manage the turn of the other player/AI.
		deferred
		end



note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
