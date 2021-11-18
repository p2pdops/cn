import socket
import time

(host, port) = (socket.gethostname(), 5000)

server_socket = socket.socket()
server_socket.bind((host, port))
server_socket.listen(2)

conn, address = server_socket.accept()
print("Connection from: " + str(address))
c = 1
while True:
    data = conn.recv(1024).decode()
    if not data:
        break
    if c % 4 == 0:  # every 4th packet is lost
        c += 1
        time.sleep(2)
        data = "Not Received"
        conn.send(data.encode())
        continue
    print("Recieved data : " + str(data))
    response = "Data recieved : " + str(data)
    conn.send(response.encode())
    c += 1

conn.close()
