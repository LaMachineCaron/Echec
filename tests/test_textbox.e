note
	description: "Test for the `textbox' class."
	author: "Alexandre Caron"
	date: "18 April 2016"
	testing: "type/manual"

class
	TEST_TEXTBOX

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	textbox:TEXTBOX

	on_prepare
			-- <Precursor>
		do
			create textbox.make (100, 100, 50, 50, 5)
		end

feature -- Test routines

	add_text_normal
			-- Normal test for `add_text'.
		do
			textbox.add_text ("Bonjour")
			assert ("add_text - test normal", textbox.text ~ "Bonjour")
		end

	sub_test_normal
			-- Normal test for `sub_test'.
		do
			textbox.add_text ("Bonjour")
			textbox.sub_text
			assert ("sub_test - test normal", textbox.text ~ "Bonjou")
		end

	sub_test_limit
			-- Limit test for `sub_test'.
		local
			i: INTEGER
		do
			textbox.add_text ("Allo")
			from
				i := 0
			until
				i > 50
			loop
				textbox.sub_text
				i := i + 1
			end
			assert ("sub_test - test limit", textbox.text ~ "")
		end

	add_text_limit
			-- Limit test for `add_test'.
		do
			textbox.clear
			textbox.add_text ("")
			assert ("add_text - test limit", textbox.text ~ "")
		end

	clear_normal
			-- Normal test for `clear'.
		do
			textbox.add_text ("Allo")
			textbox.clear
			assert("clear_normal - test normal", textbox.text ~ "")
		end

	clear_limit
			-- limit test for `clear'.
		do
			textbox.add_text ("Allo")
			textbox.clear
			textbox.clear
			assert("clear_normal - test normal", textbox.text ~ "")
		end

end


