note
	description: "Thread that manage network during a game."
	author: "Alexandre Caron"
	date: "26 April 2016"

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
		local
			l_reception: detachable ANY
		do
			from
				job_done := false
			until
				job_done = true
			loop
				l_reception := main_socket.retrieved
				if attached {GRID} l_reception as la_grid then
					grid := la_grid
					grid_received := true
				elseif attached {STRING} l_reception as la_string then
					if la_string ~ "QUITTING" then
						job_done := True
					end
				end
			end
		end


note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end

