note
	description: "Thread that wait for a connection."
	author: "Alexandre Caron"
	date: "26 April 2016"

deferred class
	NETWORK_THREAD

inherit
	THREAD

feature -- Attributs

	job_done: BOOLEAN
			-- True if the `Current' job is done.
	main_socket: NETWORK_STREAM_SOCKET
			-- The socket that will created other socket.
	socket:detachable NETWORK_STREAM_SOCKET
			-- The socket that will be created by the main_socket.
	port: INTEGER
			-- The port to connect to.

feature -- Public Methods

	reset
			-- Set `terminated' to false.
		do
			terminated := False
			job_done := False
		end

	stop_thread
			-- Set `job_done' to true.
		do
			job_done := True
		end

	has_failed:BOOLEAN

invariant

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
