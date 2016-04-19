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

	make
			--Create the `Current'.
		do
			make_thread
			job_done := False
		end

feature{NONE} -- Attributs

	job_done: BOOLEAN
			-- True if the `Current' job is done.

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
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
