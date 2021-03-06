//
//  OSCMessage.swift
//  OSCCore
//
//  Created by Sebestyén Gábor on 2017. 11. 18..
//

import Foundation

public struct OSCMessage {
    public let address: String
    public let args: [OSCMessageArgument?]

    public init(address: String, args: [OSCMessageArgument?]) {
        self.address = address
        self.args = args
    }
}
