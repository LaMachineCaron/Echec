note
	description: "Thread that wait for a connection."
	author: "Alexandre Caron"
	date: "26 April 2016"

class
	JOIN_THREAD

inherit
	NETWORK_THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make(a_ip: STRING)
			-- Create the `Current'.
		local
			l_addr_factory: INET_ADDRESS_FACTORY
		do
			make_thread
			port := 12702
			job_done := False
			has_failed := False
			create l_addr_factory
			ip := l_addr_factory.create_from_name(a_ip)
			if attached ip as la_ip then
				create main_socket.make_client_by_address_and_port (la_ip, port)
				if main_socket.invalid_address then
					has_failed := True
				end
			else
				has_failed := True
				create main_socket.make
			end
		end

feature -- Public Attributs

	ip: detachable INET_ADDRESS
			-- IP used to connect to someone else.

feature {NONE} -- Private Methods

	execute
			-- What the thread will be executing.
		do
			print(has_failed)
			if not job_done and not has_failed then
				print("Flag 2%N")
				main_socket.connect
				if not main_socket.is_connected then
					print("Flag 3%N")
					has_failed := True
				else
					print("Flag 4%N")
					main_socket.read_line
					print("Le host a dit: " + main_socket.last_string + "%N")
				end
			end
		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"

end
