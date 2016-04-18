note
	description: "Summary description for {SERVEURS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SERVEURS

inherit
	SERVER

create
	make

feature {NONE}

	make
		local
			l_port: INTEGER
			l_socket: NETWORK_STREAM_SOCKET
			--l_connecter: CONNECTOR_THREAD
		do
			l_port := 12702
			create l_socket.make_server_by_port (l_port)
			in := l_socket
			if l_socket.is_bound then
				--create l_connecter.make (l_socket)
				--l_connecter.launch
				l_socket.listen (1)
				l_socket.accept
				print("Serveur: Réception de connection.%N")
			end
		end

feature

	cleanup
		do

		end

	close
		do

		end

	process_message
		do

		end

	receive
		do

		end

end
