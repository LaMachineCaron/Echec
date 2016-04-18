note
	description: "Class containing a 2 dimension list. Used for piece's position."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	GRID

create
	make

feature{NONE} -- Initialization

	make(a_renderer:GAME_RENDERER; a_factory:RESSOURCES_FACTORY)
		do
			init_grid(a_renderer, a_factory)
			init_team(a_factory)
			init_grid_position
		end

feature -- Attributs

	grid:ARRAYED_LIST[ARRAYED_LIST[detachable PIECE]]
			-- 2 dimension list for containing `Piece' and empty space.

feature -- Methods

	init_grid(a_renderer:GAME_RENDERER; a_factory:RESSOURCES_FACTORY)
			-- Create the grid
		do
			create grid.make(8)
			across 1 |..| 8 as it loop
				grid.extend (create {ARRAYED_LIST[detachable PIECE]}.make_filled (8))
			end
		end

	init_team(a_factory:RESSOURCES_FACTORY)
			-- Initialize teams `Piece'.
		do
			--White Team
			grid.at (1).at (1) := create {ROOK}.make (a_factory.white_rook_texture, True)
			grid.at (1).at (2) := create {KNIGHT}.make (a_factory.white_knight_texture, True)
			grid.at (1).at (3) := create {BISHOP}.make (a_factory.white_bishop_texture, True)
			grid.at (1).at (4) := create {KING}.make (a_factory.white_king_texture, True)
			grid.at (1).at (5) := create {QUEEN}.make (a_factory.white_queen_texture, True)
			grid.at (1).at (6) := create {BISHOP}.make (a_factory.white_bishop_texture, True)
			grid.at (1).at (7) := create {KNIGHT}.make (a_factory.white_knight_texture, True)
			grid.at (1).at (8) := create {ROOK}.make (a_factory.white_rook_texture, True)
			grid.at (2).at (1) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (2) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (3) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (4) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (5) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (6) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (7) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			grid.at (2).at (8) := create {PAWN}.make (a_factory.white_pawn_texture, True)

			--Black Team
			grid.at (3).at (1) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (3).at (2) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (3).at (3) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (4).at (4) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (7).at (5) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (7).at (6) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (7).at (7) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (7).at (8) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			grid.at (8).at (1) := create {ROOK}.make (a_factory.black_rook_texture, False)
			grid.at (8).at (2) := create {KNIGHT}.make (a_factory.black_knight_texture, False)
			grid.at (8).at (3) := create {BISHOP}.make (a_factory.black_bishop_texture, False)
			grid.at (8).at (4) := create {KING}.make (a_factory.black_king_texture, False)
			grid.at (8).at (5) := create {QUEEN}.make (a_factory.black_queen_texture, False)
			grid.at (8).at (6) := create {BISHOP}.make (a_factory.black_bishop_texture, False)
			grid.at (8).at (7) := create {KNIGHT}.make (a_factory.black_knight_texture, False)
			grid.at (8).at (8) := create {ROOK}.make (a_factory.black_rook_texture, False)
		end

		init_grid_position
				-- set every the line and column of every piece.
		do
			across grid as la_line loop
				across la_line.item as la_column loop
					if attached la_column.item as la_piece then
						la_piece.set_grid_position (la_line.cursor_index, la_column.cursor_index)
						la_piece.move.start
					end
				end
			end
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
