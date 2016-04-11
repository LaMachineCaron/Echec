note
	description: "Class that manage server side."
	author: "Alexandre Caron"
	date: "29 March 2016"

class
	SERVEUR

create
	make

feature {NONE} -- Initialization

	make(a_window: GAME_WINDOW_RENDERED)
		do
			has_error := False
			create_socket
			if not has_error then
				wait_connection(a_window)
			end
			socket.close
		end

feature -- Methods

	create_socket
	-- Create the socket.
		local
			l_port: INTEGER
		do
			l_port := 12702
			create socket.make_server_by_port (l_port)
			if socket.is_bound then
				if attached socket.address as la_address then
					print(la_address.host_address.host_address)
				end
			else
				has_error := True
				print("Can't open port 12702")
			end
		end

	wait_connection(a_window: GAME_WINDOW_RENDERED)
		local
			l_game_engine: GAME_ENGINE
		do
			socket.listen (1)
			socket.accept
			if attached socket.accepted as la_socket then
				if attached la_socket.peer_address as la_address then
					print("Connection created")
				end
				create l_game_engine.make (a_window)
				la_socket.close
			end
		end

feature -- Attributs

	has_error: BOOLEAN -- True if there's a error,false otherwise.
	socket: NETWORK_STREAM_SOCKET

invariant

note
	copyright: "Copyright (c) 2016, Alexandre Caron"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
