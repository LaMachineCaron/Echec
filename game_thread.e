note
	description: "Summary description for {GAME_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_THREAD

inherit
	NETWORK_THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make(a_socket:NETWORK_STREAM_SOCKET; a_grid: GRID)
			-- Create the `Current'.
		do
			make_thread
			main_socket := a_socket
			grid := a_grid
			job_done := false
			grid_received := false
			port := main_socket.port
		end

feature --Public Attributs

	grid: GRID
			-- {GRID} received from the other player.
	grid_received: BOOLEAN assign set_grid_received
			-- True if a grid as been received.

feature -- Public Methods

	set_grid_received (a_boolean: BOOLEAN)
			-- Set grid_received to True or False.
		do
			grid_received := a_boolean
		end

feature {NONE} -- Private Methods

	execute
			-- What the thread will be executing.
		do
			from
				job_done := false
			until
				job_done = true
			loop
				print("Waiting for a grid %N")
				if attached {GRID} main_socket.retrieved as la_grid then
					io.put_string(" A grid as been received %N")
					grid := la_grid
					grid_received := true
				end
			end
		end


note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end

