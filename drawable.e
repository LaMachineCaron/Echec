note
	description: "Classe abstraite pour les objets qui on une texture."
	author: "Alexandre Caron"
	date: "02 février 2016"

deferred class
	DRAWABLE

feature {NONE} -- Initialization

	make(a_texture:GAME_TEXTURE; a_dimension_x, a_dimension_y: INTEGER)
		do
			texture := a_texture
			set_dimensions(a_dimension_x, a_dimension_y)
		end

feature -- Attributs

	texture:GAME_TEXTURE
	x: INTEGER
	y: INTEGER
	dimension_x: INTEGER
	dimension_y: INTEGER

feature -- Methods

	set_positions (a_x, a_y:INTEGER)
		do
			x:= a_x
			y:= a_y
		end

	set_dimensions (a_dimension_x:INTEGER; a_dimension_y:INTEGER)
		do
			dimension_x := a_dimension_x
			dimension_y := a_dimension_y
		end
end
