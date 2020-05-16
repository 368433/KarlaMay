//
//  TokenFetchingError.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

enum TokenFetchingError: Error, LocalizedError{
    case noneInUserDefaults
    case unableToDecode
    case invalidToken(comment: String)
}
