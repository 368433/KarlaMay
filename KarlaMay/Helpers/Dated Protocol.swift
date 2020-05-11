//
//  Dated Protocol.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

protocol Dated: Comparable {
    var startDate: Date? { get set }
}

extension Dated {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard let date1 = lhs.startDate else {return false}
        guard let date2 = rhs.startDate else {return true}
        return date1 < date2
    }
}
