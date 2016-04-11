note
	description: "Class for user to enter text."
	author: "Alexandre Caron"
	date: "04 April 2016"

class
	TEXTBOX

create
	make

feature {NONE} -- Initialization

	make(a_x, a_y, a_width, a_height, a_padding:INTEGER)
	-- Create a `Current' using is position and dimension.
		do
			info := [a_x, a_y, a_width, a_height, a_padding]
			is_selected := False
			text := ""
		end

feature -- Attributs

	info:TUPLE[x, y, width, height, padding:INTEGER] -- Position and dimension info about the textbox.
	is_selected: BOOLEAN assign set_selected -- True if the textbox is currently selected.
	text: STRING_32 -- The text contained in the textbox.

feature -- Methods

	clear
			--Clear the text from the Textbox.
		do
			text := ""
		end

	add_text(a_text:STRING_32)
	-- Add `a_text' to the `text'.
		do
			text := text + a_text
		ensure
			addition_succes: old text.count < text.count
		end

	sub_text
	-- Delete a charactere from `text'.
		do
			text := text.substring (1, text.count - 1)
		ensure
			deletion_succes: old text.count > text.count
		end

	set_selected(a_bool:BOOLEAN)
	-- Set the `is_selected' at `a_bool'.
		do
			is_selected := a_bool
		end

	flashing_cursor(a_window: GAME_WINDOW_RENDERED; a_factory: RESSOURCES_FACTORY)
	-- Make a little flashing line in the cursor.
		local
			l_position: TUPLE[x, y: INTEGER]
		do
			if is_selected then
				create l_position
				if a_factory.ubuntu_font.text_dimension (text).width + info.padding < info.width then
					l_position.x := info.x + info.padding + a_factory.ubuntu_font.text_dimension (text).width
				else
					l_position.x := info.x + info.width - info.padding
				end
				l_position.y := info.y
				a_window.renderer.drawing_color := a_factory.black
				a_window.renderer.draw_filled_rectangle (l_position.x, l_position.y + 2, 2, info.height - 4)
			end
		end

invariant

	valid_info_position: info.x >= 0 and info.y >= 0
	valid_info_dimension: info.width > 0 and info.height > 0

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
