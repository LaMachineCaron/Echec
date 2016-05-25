note
	description: "Class managing the game."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	GAME_ENGINE_SINGLEPLAYER

inherit
	GAME_ENGINE_NON_LOCAL
		redefine
			normal_deplacement,
			kill_deplacement
		end

create
	make_multiplayer

feature{NONE} -- Initialization

feature -- Attributs

feature {NONE} -- Private Methods

	other_player_turn
			-- <Precursor>
		local
			l_playable_piece: LINKED_LIST[PIECE]
			l_random: RANDOM
			l_piece_index: INTEGER
			l_movement_index: INTEGER
			l_turn_done: BOOLEAN
		do
			l_playable_piece := scan
			create l_random.set_seed (game_library.time_since_create.to_integer_32)
			from
				l_turn_done := False
			until
				l_turn_done = True
			loop
				l_random.forth
				l_piece_index := (l_random.item \\ l_playable_piece.count) + 1
				selected_piece := l_playable_piece.at (l_piece_index)
				calcul_valid_movement
				if attached valid_movements as la_movements and attached valid_kills as la_kills then
					if la_kills.count > 0 then
						kill_deplacement (la_kills.first)
						l_turn_done := True
					elseif la_movements.count > 0 then
						l_movement_index := (l_random.item \\ la_movements.count) + 1
						normal_deplacement (la_movements.at (l_movement_index))
						l_turn_done := True
					else
						if attached selected_piece as la_piece then
							l_playable_piece.prune (la_piece)
						end
					end
				end
			end
			draw_all
			turn_is_done := False
		end

	scan: LINKED_LIST[PIECE]
			-- Scan the chessboard for recreating the `ai_alive_pieces'.
		do
			create {LINKED_LIST[PIECE]} Result.make
			across grid.grid as la_line loop
				across la_line.item as la_column loop
					if attached {PIECE} la_column.item as la_piece then
						if la_piece.is_black then
							Result.extend (la_piece)
						end
					end
				end
			end
		end

	normal_deplacement (l_position: TUPLE[line, column :INTEGER])
			-- <Precusor>
		do
			Precursor (l_position)
			if is_white_turn /= is_player_white and not turn_is_done then
				turn_is_done := true
				other_player_turn
			end
		end

	kill_deplacement (l_position: TUPLE[line, column :INTEGER])
			-- <Precusor>
		do
			Precursor (l_position)
			if is_white_turn /= is_player_white and not turn_is_done then
				turn_is_done := true
				other_player_turn
			end
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
