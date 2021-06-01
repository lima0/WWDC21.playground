//
//  Client.swift
//  WWDC21
//
//  Created by Selim Farahat on 06/04/2021.
//

import Foundation
import Network

public class Client {
    
    static let socket = Client()
    var connection: Connection? = nil
    
    static public func connect(port: Int) {
        socket.startConnection(port: UInt16(port))
    }
    
    static public func close() {
        socket.connection?.close()
    }
    
    static public func write(data: Data, completion: @escaping (NWError?) -> Void) {
        socket.connection?.write(data: data, completion: completion)
    }
    
    private func startConnection(port: UInt16) {
        let nwConnection = NWConnection(host: "127.0.0.1", port:  NWEndpoint.Port(rawValue:port)!, using: .tcp)
        connection = Connection(connection: nwConnection)
        connection!.start()
    }
}
