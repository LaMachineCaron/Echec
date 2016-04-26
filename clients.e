note
	description: "Summary description for {CLIENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENTS

inherit
	CLIENT

create
	make

feature {NONE}

	make(a_ip: STRING)
		local
			l_port: INTEGER
			l_address: detachable INET_ADDRESS
			l_address_factory: INET_ADDRESS_FACTORY
			l_socket: NETWORK_STREAM_SOCKET
		do
			l_port := 12702
			create l_address_factory.default_create
			l_address := l_address_factory.create_from_name (a_ip)
			if l_address /= Void then
				create l_socket.make_client_by_address_and_port (l_address, l_port)
				in_out := l_socket
			else
				create l_socket.make
				in_out := l_socket
			end
			print("Client: Connection avec un serveur.%N")
		end

feature

	cleanup
		do

		end

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
	
end
