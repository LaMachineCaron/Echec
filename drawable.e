note
	description: "Abstract class for object with a texture."
	author: "Alexandre Caron"
	date: "02 february 2016"

deferred class
	DRAWABLE

feature {NONE} -- Initialization

	make(a_texture:GAME_TEXTURE; a_width, a_height: INTEGER)
	-- Create a drawable object using a texture and dimensions.
		do
			set_positions (0,0)
			texture := a_texture
			set_dimensions(a_width, a_height)
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

	set_dimensions (a_width, a_height:INTEGER)
	-- Set the `width` and `height` of the drawable
		require
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			width := a_width
			height := a_height
		ensure
			width_setted: width = a_width
			height_setted: height = a_height
		end
end
