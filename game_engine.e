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

feature{NONE} -- Constructor

	make

		local
			window_builder:GAME_WINDOW_RENDERED_BUILDER
			window:GAME_WINDOW_RENDERED
			l_multijoueur:MULTIJOUEUR
		do
			create window_builder
			window_builder.set_dimension(800, 600)
			window_builder.set_title("Jeu Échec")
			window := window_builder.generate_window
			create l_multijoueur.make(window.renderer, "./Ressources/button.png")
			l_multijoueur.set_positions(400, 300)
			draw(window.renderer)
			draw_button(window.renderer, l_multijoueur)
			set_agents
			window.update
			game_library.launch
		end

feature {NONE}

	set_agents

		do
			game_library.quit_signal_actions.extend(agent (a_timestamp:NATURAL_32) do game_library.stop end)
		end

	draw(renderer: GAME_RENDERER)
		do
			renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			renderer.draw_line (100, 100, 425, 260)
		end

	draw_button(a_window:GAME_RENDERER; a_multijoueur:BOUTONS)
		do
			a_window.draw_texture (a_multijoueur, a_multijoueur.position_x, a_multijoueur.position_y)
		end

feature
	--Variables



end
