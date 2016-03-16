note
	description: "Class containing a 2 dimension list. Used for piece's position."
	author: "Alexandre Caron"
	date: "02 february 2016"

class
	GRID

create
	make

feature{NONE} -- Initialization

	make(a_renderer:GAME_RENDERER; a_game_images:GAME_IMAGES_FACTORY)
		do
			init_grid(a_renderer, a_game_images)
			init_white_team(a_game_images)
			init_black_team(a_game_images)
		end

feature -- Attributs

	grid:ARRAYED_LIST[ARRAYED_LIST[detachable PIECE]]

feature -- Methods

	init_grid(a_renderer:GAME_RENDERER; a_game_images:GAME_IMAGES_FACTORY)
	-- Create the grid
		do
			create grid.make(8)
			across 1 |..| 8 as it loop
				grid.extend (create {ARRAYED_LIST[detachable PIECE]}.make_filled (8))
			end
		end

	init_white_team(a_game_images:GAME_IMAGES_FACTORY)
	-- Initialize white team
		do
			grid.at (1).at (1) := create {ROOK}.make (a_game_images.white_rook_texture, True)
			grid.at (1).at (2) := create {KNIGHT}.make (a_game_images.white_knight_texture, True)
			grid.at (1).at (3) := create {BISHOP}.make (a_game_images.white_bishop_texture, True)
			grid.at (1).at (4) := create {KING}.make (a_game_images.white_king_texture, True)
			grid.at (1).at (5) := create {QUEEN}.make (a_game_images.white_queen_texture, True)
			grid.at (1).at (6) := create {BISHOP}.make (a_game_images.white_bishop_texture, True)
			grid.at (1).at (7) := create {KNIGHT}.make (a_game_images.white_knight_texture, True)
			grid.at (1).at (8) := create {ROOK}.make (a_game_images.white_rook_texture, True)
			grid.at (2).at (1) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (2) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (3) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (4) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (5) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (6) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (7) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
			grid.at (2).at (8) := create {PAWN}.make (a_game_images.white_pawn_texture, True)
		end


	init_black_team(a_game_images:GAME_IMAGES_FACTORY)
	-- Initialize black team
		do
			grid.at (3).at (1) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (3).at (2) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (3).at (3) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (7).at (4) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (7).at (5) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (7).at (6) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (7).at (7) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (7).at (8) := create {PAWN}.make (a_game_images.black_pawn_texture, False)
			grid.at (8).at (1) := create {ROOK}.make (a_game_images.black_rook_texture, False)
			grid.at (8).at (2) := create {KNIGHT}.make (a_game_images.black_knight_texture, False)
			grid.at (8).at (3) := create {BISHOP}.make (a_game_images.black_bishop_texture, False)
			grid.at (8).at (4) := create {KING}.make (a_game_images.black_king_texture, False)
			grid.at (8).at (5) := create {QUEEN}.make (a_game_images.black_queen_texture, False)
			grid.at (8).at (6) := create {BISHOP}.make (a_game_images.black_bishop_texture, False)
			grid.at (8).at (7) := create {KNIGHT}.make (a_game_images.black_knight_texture, False)
			grid.at (8).at (8) := create {ROOK}.make (a_game_images.black_rook_texture, False)
		end
end
