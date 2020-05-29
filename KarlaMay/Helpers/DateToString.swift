//
//  DateToString.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation


extension Date {
    var toString: String {
        let formater = DateFormatter()
        formater.dateFormat = "d MMM yy"
//        formater.dateStyle = .full
        return formater.string(from: self)
    }
}
