//
//  Connection.swift
//  WWDC21
//
//  Created by Selim Farahat on 06/04/2021.
//

import Foundation
import Network

public class Connection {
    let connection: NWConnection
    var dataHandler: ((Data, Connection) -> Void)? = nil

    init(connection: NWConnection) {
        self.connection = connection
    }
    
    func start() {
        self.connection.stateUpdateHandler = stateChanged(to:)
        self.startReceiving()
        self.connection.start(queue: .main)
    }
    
    public func write(data: Data, completion: @escaping (NWError?) -> Void) {
        self.connection.send(content: data, completion: .contentProcessed(completion))
    }
    
    public func close() {
        self.connection.stateUpdateHandler = nil
        self.connection.cancel()
    }
    
    private func stateChanged(to state: NWConnection.State) {
        switch state {
        case .failed(let error):
            print(error.debugDescription)
            close()
        default:
            break
        }
    }
    
    private func startReceiving() {
        self.connection.receive(minimumIncompleteLength: 1, maximumLength: 65535) { (data, _, isMessageComplete, error) in
            if let data = data, !data.isEmpty {
                self.dataHandler?(data, self)
            }
            if isMessageComplete {
                //connection closed, do nothing
            } else if error != nil {
                self.close()
            } else {
                self.startReceiving()
            }
        }
    }
}
