//
//  ClinicalWorkStatus.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

enum ClinicalWorkStatus: CaseIterable {
    case active, archived
    
    var label: String {
        // create inpatient, outpatient, completed, transfered
        switch self {
        case .active:
            return "Active"
        case .archived:
            return "Archived"
        }
    }
    
    var image: Image {
        switch self {
        case .active:
            return Image(systemName: "timelapse")
        case .archived:
            return Image(systemName: "archivebox")
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        // Demonstrates simpler syntax for predicate buidling
        case .active:
            return NSPredicate(format: "%K == true", "isActive")
        case .archived:
            return NSPredicate(format: "%K == false", "isActive")
        }
    }
    
    var descriptors: [NSSortDescriptor] {
        switch self {
        default:
            return [NSSortDescriptor(keyPath: \ClinicalWork.startDate, ascending: true)]
        }
    }
    
}
