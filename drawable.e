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
	-- Set the position of the drawable with the arguments
		do
			x:= a_x
			y:= a_y
		end

	set_dimensions (a_width:INTEGER; a_height:INTEGER)
	-- Set the dimension of the drawable
		do
			width := a_width
			height := a_height
		end
end
