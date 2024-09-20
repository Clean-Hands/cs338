### Lazuli Kleinhans and Aadi Akyianu

# ===== DAYTIME =====

### Identify the parts of the TCP 3-way handshake by listing the frame summaries of the relevant frames.
`1	192.168.161.128		129.6.15.28		TCP 	[SYN] Seq=0 Win=32120 Len=0 MSS=1460 SACK_PERM TSval=3322238378 TSecr=0 WS=128`

`2	129.6.15.28		192.168.161.128		TCP		[SYN, ACK] Seq=0 Ack=1 Win=64240 Len=0 MSS=1460`

`3	192.168.161.128		129.6.15.28		TCP		[ACK] Seq=1 Ack=1 Win=32120 Len=0`
### What port number does the client (i.e. nc on your Kali computer) use for this interaction?
`192.168.161.128`
### Why does the client need a port?
So that the time server can tell the client where to direct the response
### What frame contains the actual date and time? (Show the frame summary as in question 1 above.)
`4	129.6.15.28		192.168.161.128		DAYTIME	DAYTIME Response`
### What do [SYN] and [ACK] mean?
Synchronize and Acknowlege
### Which entity (the nc client or the daytime server) initiated the closing of the TCP connection? How can you tell?
The daytime server initiated the closing. I can tell because in this frame:

`6	129.6.15.28		192.168.161.128		TCP		[FIN, PSH, ACK] Seq=52 Ack=1 Win=64240 Len=0`

We can see that `129.6.15.28` (the time server) is sending the first `[FIN]` request.


# ===== HTTP =====

### How many TCP connections were opened? How can you tell?
2, because that is how many [SYN] handshakes were done.
### Can you tell where my homepage (index.html) was requested? (If not, why not? If so, include frame summaries and/or other info that supports your answer.)
It was requested in this frame:

`7	192.168.161.128		172.233.221.124	HTTP	GET /index.html	HTTP/1.1`

I can tell because it is sending a `GET` request for the `/index.html` file.
### Can you tell where my photograph (jeff-square-colorado.jpg) was requested? (If not, why not? If so, include frame summaries and/or other info that supports your answer.)
`11	192.168.161.128		172.233.221.124	HTTP	GET /jeff-square-colorado.jpg HTTP/1.1`

I can tell because it is sending a `GET` request for the `/jeff-square-colorado.jpg` file.

# ===== QUESTIONS =====
I was really curious how to interpret the sending/receiving of the image data; how does the client understand which packet is for which image? How does it know when an image is done?
