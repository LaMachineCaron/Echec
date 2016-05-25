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
			across 1 |..| 8 as la_index loop
				grid.at (2).at (la_index.item) := create {PAWN}.make (a_factory.white_pawn_texture, True)
			end

			--Black Team
			across 1 |..| 8 as la_index loop
				grid.at (7).at (la_index.item) := create {PAWN}.make (a_factory.black_pawn_texture, False)
			end
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

	reverse
			-- exchange the position of white and black.
		local
			l_pieces:LINKED_LIST[PIECE]
		do
			create l_pieces.make
			across grid as la_line loop
					across la_line.item as la_column loop
						if attached {PIECE} la_column.item as la_piece then
							if attached la_piece.position as la_position then
								la_piece.set_grid_position (8 - la_position.line + 1, la_position.column)
								l_pieces.extend (la_piece)
							end
						end
					end
				end
			refresh(l_pieces)
		end

	refresh (a_pieces: LIST[PIECE])
			-- Reset the position of all {PIECE}
		local
			i: INTEGER
			j: INTEGER
		do
			from
				i := 1
			until
				i > 8
			loop
				from
					j := 1
				until
					j > 8
				loop
					grid.at (i).at (j) := void
					j := j + 1
				end
				i := i + 1
			end
			across a_pieces as la_piece loop
				if attached la_piece.item.position as la_position then
					grid.at (la_position.line).at (la_position.column) := la_piece.item
				end
			end
		end

	update (a_factory:RESSOURCES_FACTORY)
			-- Reset texture of all the pieces in the {GRID}.
		do
			across grid as la_grid loop
				across la_grid.item as la_item loop
					if attached {PAWN} la_item.item as la_pawn then
						if la_pawn.is_white then
							la_pawn.change_texture (a_factory.white_pawn_texture)
						else
							la_pawn.change_texture (a_factory.black_pawn_texture)
						end
					elseif attached {ROOK} la_item.item as la_rook then
						if la_rook.is_white then
							la_rook.change_texture (a_factory.white_rook_texture)
						else
							la_rook.change_texture (a_factory.black_rook_texture)
						end
					elseif attached {BISHOP} la_item.item as la_bishop then
						if la_bishop.is_white then
							la_bishop.change_texture (a_factory.white_bishop_texture)
						else
							la_bishop.change_texture (a_factory.black_bishop_texture)
						end
					elseif attached {KNIGHT} la_item.item as la_knight then
						if la_knight.is_white then
							la_knight.change_texture (a_factory.white_knight_texture)
						else
							la_knight.change_texture (a_factory.black_knight_texture)
						end
					elseif attached {KING} la_item.item as la_king then
						if la_king.is_white then
							la_king.change_texture (a_factory.white_king_texture)
						else
							la_king.change_texture (a_factory.black_king_texture)
						end
					elseif attached {QUEEN} la_item.item as la_queen then
						if la_queen.is_white then
							la_queen.change_texture (a_factory.white_queen_texture)
						else
							la_queen.change_texture (a_factory.black_queen_texture)
						end
					end
				end
			end
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
