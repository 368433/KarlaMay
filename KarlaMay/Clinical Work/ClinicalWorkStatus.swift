//
//  ClinicalWorkStatus.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

enum ClinicalWorkStatus: CaseIterable {
    case main, active, starred, archived 
    
    var label: String {
        switch self {
        case .active:
            return "Active"
        case .archived:
            return "Archived"
        case .starred:
            return "Starred"
        case .main:
            return "Main"
        }
    }
}
