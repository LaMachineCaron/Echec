note
	description: "Summary description for {NETWORK_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONNECTOR_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature{NONE} -- Initialization

	make
			--Create the `Current'.
		do
			make_thread
			create socket.make_server_by_port (12702)
			job_done := False
			has_failed := False
		end

feature -- Attributs

	job_done: BOOLEAN
			-- True if the `Current' job is done.
	socket: NETWORK_STREAM_SOCKET
			-- The socket for creating the connection.

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

feature -- Private Methods

	execute
			-- What the thread will be executing.
		local
			l_retry:BOOLEAN
		do
			if not l_retry then
				print("Thread")
				socket.listen (1)
				socket.accept
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
