//
//  AuthOTokenResponsePayload.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct AuthOTokenResponsePayload: Codable {
    var accessToken: String = ""
    var tokenType: String = ""
    var expiresIn: Int = 0

}

@propertyWrapper
struct WHOICDToken {
    private var icdAPIToken: AuthOTokenResponsePayload
    init(){ self.icdAPIToken = AuthOTokenResponsePayload() }
    init(token: AuthOTokenResponsePayload) { self.icdAPIToken = token }
    
    var wrappedValue: AuthOTokenResponsePayload {
        get { return icdAPIToken }
        set { icdAPIToken = newValue; dateCreated = Date() }
    }
    
    private var dateCreated = Date()
    func value() -> String { return wrappedValue.accessToken }
    func isValid() -> Bool {
        return Date().timeIntervalSince(dateCreated) < Double(icdAPIToken.expiresIn)
    }
}
