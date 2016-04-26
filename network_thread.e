note
	description: "Thread to manage network."
	author: "Alexandre Caron"
	date: "19 April 2016"

class
	NETWORK_THREAD

inherit
	THREAD
	rename
		make as make_thread
	end

create
	make

feature{NONE} -- Initialization

	make(a_socket:NETWORK_STREAM_SOCKET)
			--Create the `Current'.
		do
			make_thread
			socket := a_socket
			job_done := False
		end

feature{NONE} -- Attributs

	job_done: BOOLEAN
			-- True if the `Current' job is done.
	socket: NETWORK_STREAM_SOCKET
			-- Socket that listen.

feature -- Public Methods

	reset
			-- Set `terminated' to false.
		do
			terminated := False
		end

	stop_thread
			-- Set `job_done' to true.
		do
			job_done := True
		end

feature -- Private Methods

	execute
			-- What the thread will be executing.
		do
			print("Thread")
			socket.listen(1)
			socket.accept
			stop_thread
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
