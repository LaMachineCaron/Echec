note
	description: "Summary description for {GAME_IMAGES_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_IMAGES_FACTORY

inherit
	IMAGES_FACTORY

create
	make

feature {NONE} -- Initialization

	make(a_renderer:GAME_RENDERER)
		do
			white_rook_texture:= set_texture(a_renderer, "./Ressources/white_rook.png")
			white_knight_texture:= set_texture(a_renderer, "./Ressources/white_knight.png")
			white_bishop_texture:= set_texture(a_renderer, "./Ressources/white_bishop.png")
			white_king_texture:= set_texture(a_renderer, "./Ressources/white_king.png")
			white_queen_texture:= set_texture(a_renderer, "./Ressources/white_queen.png")
			white_pawn_texture:= set_texture(a_renderer, "./Ressources/white_pawn.png")
			black_rook_texture:= set_texture(a_renderer, "./Ressources/black_rook.png")
			black_knight_texture:= set_texture(a_renderer, "./Ressources/black_knight.png")
			black_bishop_texture:= set_texture(a_renderer, "./Ressources/black_bishop.png")
			black_king_texture:= set_texture(a_renderer, "./Ressources/black_king.png")
			black_queen_texture:= set_texture(a_renderer, "./Ressources/black_queen.png")
			black_pawn_texture:= set_texture(a_renderer, "./Ressources/black_pawn.png")
			game_background := set_texture(a_renderer, "./Ressources/chessboard.png")

		end

feature -- Attributs

	white_rook_texture:GAME_TEXTURE
	white_knight_texture:GAME_TEXTURE
	white_bishop_texture:GAME_TEXTURE
	white_king_texture:GAME_TEXTURE
	white_queen_texture:GAME_TEXTURE
	white_pawn_texture:GAME_TEXTURE
	black_rook_texture:GAME_TEXTURE
	black_knight_texture:GAME_TEXTURE
	black_bishop_texture:GAME_TEXTURE
	black_king_texture:GAME_TEXTURE
	black_queen_texture:GAME_TEXTURE
	black_pawn_texture:GAME_TEXTURE
	game_background:GAME_TEXTURE

end
