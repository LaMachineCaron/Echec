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
			set_dimensions
		end

feature -- Attributs

	texture:GAME_TEXTURE	-- Texture of the drawable
	x: INTEGER	-- x position
	y: INTEGER	-- y position
	width: INTEGER	-- Width of the drawable (Texture)
	height: INTEGER	-- Height of the drawable (Texture)

feature -- Methods

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

	set_dimensions
	-- Set the `width` and `height` from the texture to the drawable
		require
			valid_width: texture.width > 0
			valid_height: texture.height > 0
		do
			width := texture.width
			height := texture.height
		ensure
			width_setted: width = texture.width
			height_setted: height = texture.height
		end

invariant
	valid_dimensions: width > 0 and height > 0 and texture.width = width and texture.height = height
	valid_positions: x >= 0 and y >= 0

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
