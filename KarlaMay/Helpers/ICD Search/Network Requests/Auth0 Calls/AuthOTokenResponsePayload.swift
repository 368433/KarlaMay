//
//  AuthOTokenResponsePayload.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct AuthOTokenResponsePayload: Codable {
    var accessToken: String = "No token value"
    var tokenType: String = ""
    var expiresIn: Int = 0

}
