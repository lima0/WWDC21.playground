//
//  Server.swift
//  WWDC21
//
//  Created by Selim Farahat on 06/04/2021.
//

import Foundation
import Network

public class Server {
    
    public static var dataReceived: ((Data, Connection) -> Void)? = nil
    static let socket = Server()
    var listener: NWListener? = nil
    private init() {}
    
    static public func bindAndListen(port: Int) {
        socket.activate(port: port)
    }
    
    static public func close() {
        socket.listener?.cancel()
    }
    
    private func activate(port: Int) {
        listener = try! NWListener(using: .tcp, on: NWEndpoint.Port(rawValue: NWEndpoint.Port.RawValue(port))!)
        listener!.stateUpdateHandler = self.stateChanged(to:)
        listener!.newConnectionHandler = self.incomingConnection(nwConnection:)
        listener!.start(queue: .main)
    }
    
    private func stateChanged(to state: NWListener.State) {
        switch state {
        case .failed(let error):
            print("The server has crashed, error: \(error)")
        default:
            break
        }
    }
    
    private func incomingConnection(nwConnection: NWConnection) {
        let connection = Connection(connection: nwConnection)
        connection.start()
        connection.dataHandler = Server.dataReceived
    }
}

