//
//  SocketWrapper.swift
//  morpion
//
//  Created by Benjamin Courtine on 26/06/2019.
//  Copyright © 2019 Ben. All rights reserved.
//

import Foundation
import SocketIO

class SocketWrapper {
    
    static let shared =  SocketWrapper()
    
    var manager:SocketManager
    var socket:SocketIOClient
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: "http://51.254.112.146:5666")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        self.socket.connect()
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
}
