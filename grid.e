note
	description: "Classe contenant le tableau 2 dimensions du jeu."
	author: "Alexandre Caron"
	date: "02 février 2016"

class
	GRID

create
	make

feature{NONE} -- Initialization

	make(a_renderer:GAME_RENDERER)
		do
			init_grid(a_renderer)
		end

feature -- Attributs

	grid:ARRAYED_LIST[ARRAYED_LIST[detachable PIECE]]

feature -- Methods

	init_grid(a_renderer:GAME_RENDERER)
		do
			create grid.make(8)
			across 1 |..| 8 as it loop
				grid.extend (create {ARRAYED_LIST[detachable PIECE]}.make_filled (8))
			end

			-- Initialize white team
			grid.at (1).at (1) := create {ROOK}.make(a_renderer, "./Ressources/white_rook.png", True)
			grid.at (1).at (2) := create {KNIGHT}.make (a_renderer, "./Ressources/white_knight.png", True)
			grid.at (1).at (3) := create {BISHOP}.make (a_renderer, "./Ressources/white_bishop.png", True)
			grid.at (1).at (4) := create {KING}.make (a_renderer, "./Ressources/white_king.png", True)
			grid.at (1).at (5) := create {QUEEN}.make (a_renderer, "./Ressources/white_queen.png", True)
			grid.at (1).at (6) := create {BISHOP}.make (a_renderer, "./Ressources/white_bishop.png", True)
			grid.at (1).at (7) := create {KNIGHT}.make (a_renderer, "./Ressources/white_knight.png", True)
			grid.at (1).at (8) := create {ROOK}.make (a_renderer, "./Ressources/white_rook.png", True)
			grid.at (2).at (1) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (2) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (3) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (4) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (5) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (6) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (7) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)
			grid.at (2).at (8) := create {PAWN}.make (a_renderer, "./Ressources/white_pawn.png", True)

			-- Initialize black team
			grid.at (7).at (1) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (2) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (3) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (4) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (5) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (6) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (7) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (7).at (8) := create {PAWN}.make (a_renderer, "./Ressources/black_pawn.png", False)
			grid.at (8).at (1) := create {ROOK}.make (a_renderer, "./Ressources/black_rook.png", False)
			grid.at (8).at (2) := create {KNIGHT}.make (a_renderer, "./Ressources/black_knight.png", False)
			grid.at (8).at (3) := create {BISHOP}.make (a_renderer, "./Ressources/black_bishop.png", False)
			grid.at (8).at (4) := create {KING}.make (a_renderer, "./Ressources/black_king.png", False)
			grid.at (8).at (5) := create {QUEEN}.make (a_renderer, "./Ressources/black_queen.png", False)
			grid.at (8).at (6) := create {BISHOP}.make (a_renderer, "./Ressources/black_bishop.png", False)
			grid.at (8).at (7) := create {KNIGHT}.make (a_renderer, "./Ressources/black_knight.png", False)
			grid.at (8).at (8) := create {ROOK}.make (a_renderer, "./Ressources/black_rook.png", False)

		end
end
