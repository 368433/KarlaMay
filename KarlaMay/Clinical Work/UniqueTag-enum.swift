//
//  UniqueTag-enum.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

enum UniqueTagsOptions {
    case mainClinicalList, flagged, archived
    
    var associatedLabel: String {
        switch self {
        case .mainClinicalList:
            return "mainClinicalWorkList"
        default:
            return ""
        }
    }
}
