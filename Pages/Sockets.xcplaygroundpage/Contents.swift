
/*:
 [The Internet Explained](@previous)
 
 # Network Sockets
 Network sockets are the API (Application Programming Interface) that most computers use to communicate today. This playground visualizes the communication between 2 hosts (computers).
 
 ### Bind and Listen
 The server binds itself to a port number and interface and listens to connections on certain host IPs (Use the toggle to do that)
 
 ### Client Connect and Server Accept
 The client creates a socket and connects to the server socket and the server accepts that connection. (The button will use the client socket to connect to the server and send the message in the text field.)
 
 ### Data transfer
 Both hosts can read and write to the connection (In this playground, the button uses the client to write to the connection and the server outputs the message in a text field.)
 
 ### Close
 Either Client can terminate the connection by closing the socket. (The playground client does this automatically after sending the message)
 */

// You can change the port for the server and client, it will work as long as they are communicating on the same port
// Port ranges are from 0-65535, 0-1023 are well-known ports for defined purposes such as browsing websites with HTTPS (port 443), 1024-49151 are registered and 49152-65535 are for dynamic use by applications, for example to make requests

let clientPort = /*#-editable-code*/3333/*#-end-editable-code*/
let serverPort = /*#-editable-code*/3333/*#-end-editable-code*/

//#-hidden-code
import PlaygroundSupport
let view = SocketsViewController()
view.clientPort = clientPort
view.serverPort = serverPort
PlaygroundPage.current.liveView = view
//#-end-hidden-code
//: [HTTP Server](@next)
