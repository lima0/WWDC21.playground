/*:
 [Sockets](@previous)
 # The HTTP Protocol
 As explained in the previous pages, the internet uses protocols to communicate between devices, one of them being HTTP (Hypertext Transfer Protocol). HTTP is used to transfer and show HTML (Hypertext Markup Language) pages, so basically any webpage you see on the internet.
 
 The HTTP Client uses port 80, opens a socket and sends a request message that is usually in the format of ``<METHOD> <LOCATION> <HTTP VERSION>`` and other HTTP Headers in a line after
 
 The server then responds in a similar format with the body after, which is then displayed by a browser
 
 Use the toggle in the playground to enable the server to listen on HTTP port 80 and tap [**here**](http://localhost:80) to check the output
 */

// You can play around with the body of the response here
let response = """
HTTP/1.0 200 OK\r

<html>
 <body>
   <h1>\(/*#-editable-code*/"Congratulations, your HTTP server works!"/*#-end-editable-code*/)</h1>
 </body>
</html>
"""
// What the server does when it gets a request:
Server.dataReceived = { data, connection in
    // prints the data received if you want to see it in the output
    print(String(data: data, encoding: .utf8)!)
    // writes the response in the connection
    connection.write(data: Data(response.utf8)) { _ in
        // closes the connection after writing
        connection.close()
    }
}
//#-hidden-code
import PlaygroundSupport
import Foundation

let view = ServerView()
PlaygroundPage.current.liveView = view
//#-end-hidden-code
