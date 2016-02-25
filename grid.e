note
	description: "Summary description for {BACKGROUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRID

inherit
	DRAWABLE
	rename make as
		make_drawable
	end

create
	make

feature{NONE}

	make(a_window: GAME_RENDERER; a_image_file: STRING; a_dimension_x: INTEGER; a_dimension_y: INTEGER)
		local
			l_image:IMG_IMAGE_FILE
		do
			has_error := False
			create_sprites_list
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image(a_window, l_image)
					set_dimensions(a_dimension_x, a_dimension_y)
					init_pieces(a_window)
				else
					has_error := True
				end
			else
				has_error := True
			end
		end

feature

	sprites:ARRAYED_LIST[PIECE]
	create_sprites_list
	do
		create sprites.make(32)
	end

	init_pieces(a_renderer:GAME_RENDERER)
		local
			l_white_rook1:TOUR
			l_white_rook2:TOUR
			l_white_bishop1:FOU
			l_white_bishop2:FOU
			l_white_knight1:CAVALIER
			l_white_knight2:CAVALIER
			l_white_king:ROI
			l_white_queen:REINE
			l_white_pawn1:PION
			l_white_pawn2:PION
			l_white_pawn3:PION
			l_white_pawn4:PION
			l_white_pawn5:PION
			l_white_pawn6:PION
			l_white_pawn7:PION
			l_white_pawn8:PION
			l_black_rook1:TOUR
			l_black_rook2:TOUR
			l_black_knight1:CAVALIER
			l_black_knight2:CAVALIER
			l_black_bishop1:FOU
			l_black_bishop2:FOU
			l_black_king:ROI
			l_black_queen:REINE
			l_black_pawn1:PION
			l_black_pawn2:PION
			l_black_pawn3:PION
			l_black_pawn4:PION
			l_black_pawn5:PION
			l_black_pawn6:PION
			l_black_pawn7:PION
			l_black_pawn8:PION

		do
			create l_white_rook1.make (0, 0, a_renderer, "./Ressources/white_rook.png")
			sprites.extend (l_white_rook1)
			create l_white_rook2.make (7, 0, a_renderer, "./Ressources/white_rook.png")
			sprites.extend (l_white_rook2)
			create l_white_knight1.make (1, 0, a_renderer, "./Ressources/white_knight.png")
			sprites.extend (l_white_knight1)
			create l_white_knight2.make (6, 0, a_renderer, "./Ressources/white_knight.png")
			sprites.extend (l_white_knight2)
			create l_white_bishop1.make (2, 0, a_renderer, "./Ressources/white_bishop.png")
			sprites.extend (l_white_bishop1)
			create l_white_bishop2.make (5, 0, a_renderer, "./Ressources/white_bishop.png")
			sprites.extend (l_white_bishop2)
			create l_white_king.make (3, 0, a_renderer, "./Ressources/white_king.png")
			sprites.extend (l_white_king)
			create l_white_queen.make (4, 0, a_renderer, "./Ressources/white_queen.png")
			sprites.extend (l_white_queen)
			create l_white_pawn1.make (0, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn1)
			create l_white_pawn2.make (1, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn2)
			create l_white_pawn3.make (2, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn3)
			create l_white_pawn4.make (3, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn4)
			create l_white_pawn5.make (4, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn5)
			create l_white_pawn6.make (5, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn6)
			create l_white_pawn7.make (6, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn7)
			create l_white_pawn8.make (7, 1, a_renderer, "./Ressources/white_pawn.png")
			sprites.extend (l_white_pawn8)

			create l_black_rook1.make (0, 7, a_renderer, "./Ressources/black_rook.png")
			sprites.extend (l_black_rook1)
			create l_black_rook2.make (7, 7, a_renderer, "./Ressources/black_rook.png")
			sprites.extend (l_black_rook2)
			create l_black_knight1.make (1, 7, a_renderer, "./Ressources/black_knight.png")
			sprites.extend (l_black_knight1)
			create l_black_knight2.make (6, 7, a_renderer, "./Ressources/black_knight.png")
			sprites.extend (l_black_knight2)
			create l_black_bishop1.make (2, 7, a_renderer, "./Ressources/black_bishop.png")
			sprites.extend (l_black_bishop1)
			create l_black_bishop2.make (5, 7, a_renderer, "./Ressources/black_bishop.png")
			sprites.extend (l_black_bishop2)
			create l_black_king.make (3, 7, a_renderer, "./Ressources/black_king.png")
			sprites.extend (l_black_king)
			create l_black_queen.make (4, 7, a_renderer, "./Ressources/black_queen.png")
			sprites.extend (l_black_queen)
			create l_black_pawn1.make (0, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn1)
			create l_black_pawn2.make (1, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn2)
			create l_black_pawn3.make (2, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn3)
			create l_black_pawn4.make (3, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn4)
			create l_black_pawn5.make (4, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn5)
			create l_black_pawn6.make (5, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn6)
			create l_black_pawn7.make (6, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn7)
			create l_black_pawn8.make (7, 6, a_renderer, "./Ressources/black_pawn.png")
			sprites.extend (l_black_pawn8)



		end

end
