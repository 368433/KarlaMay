//
//  ICDAPIToken.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct ICDAPIToken: Codable {
    var accessToken: String = ""
    var expiresIn: Int = 0
    var tokenType: String = ""
}
