note
	description: "Thread that wait for a connection."
	author: "Alexandre Caron"
	date: "26 April 2016"

class
	HOSTING_THREAD

inherit
	NETWORK_THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make
			--Create the `Current'.
		do
			make_thread
			port := 12702
			create main_socket.make_server_by_port (port)
			job_done := False
			has_failed := False
		end

feature {NONE} -- Private Methods

	execute
			-- What the thread will be executing.
		local
			l_retry:BOOLEAN
		do
			if not l_retry then
				main_socket.listen (1)
				main_socket.accept
				if attached main_socket.accepted as la_socket then
					socket := la_socket
					la_socket.put_string ("Bienvenue dans la partie.%N")
				end
			else
				has_failed := True
			end
			stop_thread
		rescue
			l_retry := True
			retry
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
