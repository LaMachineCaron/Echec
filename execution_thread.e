note
	description: "Summary description for {EXECUTION_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTION_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE}

	make( a_socket: NETWORK_STREAM_SOCKET)
		do
			make_thread
			socket := a_socket
		end

feature -- Attributs

	socket: NETWORK_STREAM_SOCKET

feature -- Methods

	execute
			-- The method to be executed by the thread.
		do
			socket.listen (1)
			socket.accept
		end

end
