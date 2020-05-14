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
    case main, active, archived
    
    var label: String {
        switch self {
        case .active:
            return "Active"
        case .archived:
            return "Archived"
        case .main:
            return "Main"
        }
    }
    
    var image: Image {
        switch self {
        case .active:
            return Image(systemName: "timelapse")
        case .archived:
            return Image(systemName: "archivebox")
        case .main:
            return Image(systemName: "list.dash")
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        
        // Demonstrates usage of predicates construction from parts
        case .main:
            let exp1 = NSExpression(forKeyPath: \ClinicalWork.isMainList)
            let exp2 = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: exp1, rightExpression: exp2, modifier: .direct, type: .equalTo, options: .init())
        
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
