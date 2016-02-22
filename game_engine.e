note
	description: "Summary description for {GAME_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_ENGINE

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED

create
	make

feature{NONE}

	make(a_window:GAME_WINDOW_RENDERED)

		local
			l_background:BACKGROUND
			l_sprites:ARRAYED_LIST[DRAWABLE]
		do
			a_window.clear_events
			a_window.renderer.clear
			create l_sprites.make (1)
			create l_background.make(a_window.renderer, "./Ressources/chessboard.png", 600, 600)
			l_sprites.extend (l_background)
			l_background.set_positions(0,0)
			l_sprites := import_pieces(a_window, l_sprites)
			l_sprites.do_all(agent draw_sprite(a_window.renderer, ?))
			a_window.update
		end

feature

	import_pieces(a_window:GAME_WINDOW_RENDERED; a_sprites:ARRAYED_LIST[DRAWABLE]):ARRAYED_LIST[DRAWABLE]
	local
		l_case_dimension:INTEGER
		l_border:INTEGER
		l_piece_dimension:INTEGER
		l_white_king:ROI
		l_white_rook:TOUR
		l_white_knight:CAVALIER
		l_white_bishop:FOU
		l_white_queen:REINE
		l_white_pawn:PION
	do
		l_border := 25
		l_case_dimension := 68
		l_piece_dimension := 64
		create l_white_king.make(a_window.renderer, "./Ressources/white_king.png", l_piece_dimension, l_piece_dimension)
		create l_white_rook.make(a_window.renderer, "./Ressources/white_rook.png", l_piece_dimension, l_piece_dimension)
		create l_white_knight.make(a_window.renderer, "./Ressources/white_knight.png", l_piece_dimension, l_piece_dimension)
		create l_white_bishop.make(a_window.renderer, "./Ressources/white_bishop.png", l_piece_dimension, l_piece_dimension)
		create l_white_queen.make(a_window.renderer, "./Ressources/white_queen.png", l_piece_dimension, l_piece_dimension)
		create l_white_pawn.make(a_window.renderer, "./Ressources/white_pawn.png", l_piece_dimension, l_piece_dimension)
		l_white_rook.set_positions(l_border, l_border)
		l_white_knight.set_positions(l_border + l_case_dimension + 1, l_border)
		l_white_bishop.set_positions(l_border + (2*l_case_dimension) + 1, l_border)
		l_white_king.set_positions(l_border + (3*l_case_dimension) + 1, l_border)
		l_white_queen.set_positions(l_border + (4*l_case_dimension) + 1, l_border)
		l_white_pawn.set_positions(l_border, l_border + l_case_dimension + 1)
		a_sprites.extend (l_white_king)
		a_sprites.extend (l_white_rook)
		a_sprites.extend (l_white_queen)
		a_sprites.extend (l_white_bishop)
		a_sprites.extend (l_white_pawn)
		a_sprites.extend (l_white_knight)
		Result := a_sprites
	end

	draw_sprite(a_window:GAME_RENDERER; a_sprites:DRAWABLE)
		do
			a_window.draw_texture (a_sprites, a_sprites.position_x, a_sprites.position_y)
		end

end
