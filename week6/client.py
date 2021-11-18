import socket

(host, port) = (socket.gethostname(), 5000)
client_socket = socket.socket()
client_socket.connect((host, port))

n = int(input("No of packets : "))
inp = "Enter packet of data : "

c = 0
while(c < n):
    datapacket = input(inp)
    client_socket.send(datapacket.encode())
    ACK = client_socket.recv(1024).decode()
    if(ACK == "Not Received"):
        inp = "Data not receieved resend the previous data : "
    else:
        inp = "Enter packet of data : "
        print(ACK)
        c += 1


client_socket.close()
