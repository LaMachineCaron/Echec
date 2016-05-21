note
	description: "Abstract class for images facotries."
	author: "Alexandre Caron"
	date: "01 March 2016"

class
	RESSOURCES_FACTORY

create
	make

feature -- Initialization

	make(a_renderer:GAME_RENDERER)
			-- create every ressource in the game.
		do
			create_textures(a_renderer)
			create_sounds
			create_musics
			create_colors
			create_fonts
		end

feature -- Attributs

	white_rook_texture:GAME_TEXTURE
			-- `texture' for the white {rook}.
	white_knight_texture:GAME_TEXTURE
			-- `texture' for the white {knight}.
	white_bishop_texture:GAME_TEXTURE
			-- `texture' for the white {bishop}.
	white_king_texture:GAME_TEXTURE
			-- `texture' for the white {king}.
	white_queen_texture:GAME_TEXTURE
			-- `texture' for the white {queen}.
	white_pawn_texture:GAME_TEXTURE
			-- `texture' for the white {pawn}.
	black_rook_texture:GAME_TEXTURE
			-- `texture' for the black {rook}.
	black_knight_texture:GAME_TEXTURE
			-- `texture' for the black {knight}.
	black_bishop_texture:GAME_TEXTURE
			-- `texture' for the black {bishop}.
	black_king_texture:GAME_TEXTURE
			-- `texture' for the black {king}.
	black_queen_texture:GAME_TEXTURE
			-- `texture' for the black {queen}.
	black_pawn_texture:GAME_TEXTURE
			-- `texture' for the black {pawn}.
	game_background:GAME_TEXTURE
			-- `texture' for the in_game {background}.
	possible_movement:GAME_TEXTURE
			-- `texture' that let know the possible movement of a {piece}.
	possible_kill:GAME_TEXTURE
			-- `texture' that let know the possible kill of a {piece}.
	solo_button:GAME_TEXTURE
			-- `texture' for the solo {button}.
	multiplayer_button:GAME_TEXTURE
			-- `texture' for the multiplayer network {button}.
	local_button: GAME_TEXTURE
			-- `texture' for the mutltiplayer local {button}.
	menu_background:GAME_TEXTURE
			-- `texture' for the menu {background}.
	return_button:GAME_TEXTURE
			-- `texture' for the return {button}.
	join_button:GAME_TEXTURE
			-- `texture' for the join {button}.
	host_button:GAME_TEXTURE
			-- `texture' for the host {button}.
	in_game_menu:GAME_TEXTURE
			-- `texture' for the in game meun.
	white_turn:GAME_TEXTURE
			-- `texture' telling it's white turn.
	black_turn:GAME_TEXTURE
			-- `texture' telling it's black turn.
	waiting_for_connection:GAME_TEXTURE
			-- `texture' for the {backgorund} while waiting for a player connection.
	loading:GAME_TEXTURE
			-- `texture' for a loading animation.
	game_over:GAME_TEXTURE
			-- `texture' telling players that the game is over.
	quit_button:GAME_TEXTURE
			-- `texture' for the quit {button}.

	click_sound:AUDIO
			-- Every sound in the game.

	main_music: AUDIO
			-- Every music in the game.

	black:GAME_COLOR
	white:GAME_COLOR
			-- Colors

	ubuntu_font:TEXT_FONT
			--Fonts

feature{NONE} -- Private Methods

	create_textures(a_renderer:GAME_RENDERER)
	-- Create every texture.
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
			game_background := set_texture(a_renderer, "./Ressources/chessboard2.png")
			possible_movement := set_texture(a_renderer, "./Ressources/possible_movement.png")
			possible_kill := set_texture(a_renderer, "./Ressources/possible_kill.png")
			solo_button := set_texture(a_renderer, "./Ressources/button_solo2.png")
			multiplayer_button := set_texture(a_renderer, "./Ressources/multiplayer_button2.png")
			local_button := set_texture(a_renderer, "./Ressources/local_button.png")
			menu_background := set_texture(a_renderer, "./Ressources/menu_background.png")
			return_button := set_texture(a_renderer, "./Ressources/button_return.png")
			join_button := set_texture(a_renderer, "./Ressources/button_join.png")
			host_button := set_texture(a_renderer, "./Ressources/button_host.png")
			in_game_menu := set_texture(a_renderer, "./Ressources/in_game_menu.png")
			white_turn := set_texture(a_renderer, "./Ressources/white_turn.png")
			black_turn := set_texture(a_renderer, "./Ressources/black_turn.png")
			waiting_for_connection := set_texture(a_renderer, "./Ressources/waiting_for_connection_background.png")
			loading := set_texture(a_renderer, "./Ressources/loading.png")
			game_over := set_texture(a_renderer, "./Ressources/game_over.png")
			quit_button := set_texture(a_renderer, "./Ressources/button_quit.png")
		end

	create_sounds
	-- Create every sound.
		do
			create click_sound.make("./Ressources/click.ogg")
		end

	create_musics
	-- Create every music.
		do
			create main_music.make("./Ressources/music.ogg")
		end

	create_colors
	-- Create every color.
		do
			create black.make(0, 0, 0, 0)
			create white.make(255,255,255,0)
		end

	create_fonts
	-- Create every font.
		do
			create ubuntu_font.make("./Ressources/ubuntu.ttf", 16)
			if ubuntu_font.is_openable then
				ubuntu_font.open
			end
		end

	set_texture(a_renderer:GAME_RENDERER; a_image_file:STRING):GAME_TEXTURE
	-- create a texuture using the image URL.
		local
			l_image:IMG_IMAGE_FILE
			l_texture:GAME_TEXTURE
		do
			create l_image.make (a_image_file)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					create l_texture.make_from_image (a_renderer, l_image)
				else
					l_texture := default_image(a_renderer)
				end
			else
				l_texture := default_image(a_renderer)
			end
			result := l_texture
		end

feature -- Public Methods

	default_image(a_renderer:GAME_RENDERER):GAME_TEXTURE
	-- If set texture can't create the texture, this will be the texture.
		local
			l_pixel_format:GAME_PIXEL_FORMAT
			l_texture:GAME_TEXTURE
		do
			create l_pixel_format.default_create
			l_pixel_format.set_index1lsb
			create {GAME_TEXTURE_TARGET}l_texture.make (a_renderer, l_pixel_format, 0, 0)
			result := l_texture
		end
note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
