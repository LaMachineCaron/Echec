note
	description: "Abstract class for object with a texture."
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	DRAWABLE

feature {NONE} -- Initialization

	make(a_texture:GAME_TEXTURE)
			-- Create a drawable object using a texture and dimensions.
		do
			set_positions (0,0)
			texture := a_texture
		end

	make_with_position(a_texture: GAME_TEXTURE; a_x, a_y: INTEGER)
			-- Create the `Current' using his position.
		require
			valid_a_x: a_x >= 0
			valid_a_y: a_y >= 0
		do
			set_positions (a_x, a_y)
			texture := a_texture
		end

feature -- Attributs

	texture:GAME_TEXTURE assign change_texture
			-- Texture of the drawable
	x: INTEGER
			-- x position
	y: INTEGER
			-- y position

feature -- Methods

	change_texture (a_new:GAME_TEXTURE)
			-- For changing the `Current' texture for a new one.
		do
			texture := a_new
		end

	set_positions (a_x, a_y:INTEGER)
			-- Set the position of the drawable
		require
			valid_x: a_x >= 0
			valid_y: a_y >= 0
		do
			x:= a_x
			y:= a_y
		ensure
			x_setted: x = a_x
			y_setted: y = a_y
		end

	width: INTEGER
			-- Return the `width' of the texture.
		do
			Result := texture.width
		end

	height: INTEGER
			-- Return the `height' of the texture.
		do
			Result := texture.height
		end

invariant
	valid_positions: x >= 0 and y >= 0

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
