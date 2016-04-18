note
	description: "Class managing client."
	author: "Alexandre Caron"
	date: "29 March 2016"

class
	CLIENT_TEST

feature -- Attributs



feature {NONE} -- Initialization

	make(a_ip:STRING)
			--Create the class
		local
			l_addr_factory:INET_ADDRESS_FACTORY
			l_address:INET_ADDRESS
			l_socket: NETWORK_STREAM_SOCKET
			l_port: INTEGER
		do
			l_port := 12702
			l_address := l_address_factory.create_from_name(a_ip)
			if l_address = Void then
				print("Adresse IP invalide.%N")
			else
				create l_socket.make_client_by_address_and_port (l_address, l_port)
				l_socket.connect
				if l_socket.is_connected then
					print("Starting Game%N")
					l_socket.close
				end
			end

		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
