note
	description: "Summary description for {BACKGROUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRID

create
	make

feature{NONE}

	make(a_renderer:GAME_RENDERER)
		do
			init_grid(a_renderer)
		end

feature

	grid:ARRAYED_LIST[ARRAYED_LIST[detachable PIECE]]

	init_grid(a_renderer:GAME_RENDERER)
	do
		create grid.make(8)
		across 1 |..| 8 as it loop
			grid.extend (create {ARRAYED_LIST[detachable PIECE]}.make_filled (8))
		end
--		if attached grid.at (2).piece as la_piece then -- Pour utiliser une piece
--			la_piece.f
--		end

		-- Initialize white team
		grid.at (1).at (1) := create {TOUR}.make(a_renderer, "./Ressources/white_rook.png", True)
		grid.at (1).at (2) := create {CAVALIER}.make (a_renderer, "./Ressources/white_knight.png", True)
		grid.at (1).at (3) := create {FOU}.make (a_renderer, "./Ressources/white_bishop.png", True)
		grid.at (1).at (4) := create {ROI}.make (a_renderer, "./Ressources/white_king.png", True)
		grid.at (1).at (5) := create {REINE}.make (a_renderer, "./Ressources/white_queen.png", True)
		grid.at (1).at (6) := create {FOU}.make (a_renderer, "./Ressources/white_bishop.png", True)
		grid.at (1).at (7) := create {CAVALIER}.make (a_renderer, "./Ressources/white_knight.png", True)
		grid.at (1).at (8) := create {TOUR}.make (a_renderer, "./Ressources/white_rook.png", True)
		grid.at (2).at (1) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (2) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (3) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (4) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (5) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (6) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (7) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)
		grid.at (2).at (8) := create {PION}.make (a_renderer, "./Ressources/white_pawn.png", True)

		-- Initialize black team
		grid.at (7).at (1) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (2) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (3) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (4) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (5) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (6) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (7) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (7).at (8) := create {PION}.make (a_renderer, "./Ressources/black_pawn.png", False)
		grid.at (8).at (1) := create {TOUR}.make (a_renderer, "./Ressources/black_rook.png", False)
		grid.at (8).at (2) := create {CAVALIER}.make (a_renderer, "./Ressources/black_knight.png", False)
		grid.at (8).at (3) := create {FOU}.make (a_renderer, "./Ressources/black_bishop.png", False)
		grid.at (8).at (4) := create {ROI}.make (a_renderer, "./Ressources/black_king.png", False)
		grid.at (8).at (5) := create {REINE}.make (a_renderer, "./Ressources/black_queen.png", False)
		grid.at (8).at (6) := create {FOU}.make (a_renderer, "./Ressources/black_bishop.png", False)
		grid.at (8).at (7) := create {CAVALIER}.make (a_renderer, "./Ressources/black_knight.png", False)
		grid.at (8).at (8) := create {TOUR}.make (a_renderer, "./Ressources/black_rook.png", False)

	end
end
