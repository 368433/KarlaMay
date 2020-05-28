//
//  Extension Diagnosis.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

extension Diagnosis {
    var titleLabel: String {
        guard let title = self.title else { return "Missing title"}
        return title
    }
    
    var icdCodeLabel: String {
        guard let icdCode = self.icdCode else {return "missing ICD Code"}
        return icdCode
    }
}

extension Diagnosis: Comparable {
    public static func < (lhs: Diagnosis, rhs: Diagnosis) -> Bool {
        guard let title1 = lhs.title else {return false}
        guard let title2 = rhs.title else {return false}
        return title1 < title2
    }
}
