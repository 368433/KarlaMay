//
//  Codable objects - WHOICDAPI.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct TokenValue: Codable {
    var dateCreated = Date()
    var icdAPIToken: AuthOTokenResponsePayload
    func isValid() -> Bool{
        return Date().timeIntervalSince(dateCreated) < Double(icdAPIToken.expiresIn)
    }
}
