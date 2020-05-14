//
//  SearchableContent.swift
//  karlaSUI
//
//  Created by quarticAIMBP2018 on 2020-04-28.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation
import SwiftUI

enum SearchableContent: CaseIterable {
    case patients
    case diagnostics
    case physicians
    case episodesOfCare
    case lists
    
    func predicates(keypaths: [String], searchString: String) -> NSCompoundPredicate? {
        switch self {
        case .patients:
            return searchString == "" ? nil : NSCompoundPredicate(orPredicateWithSubpredicates: keypaths.map(){key in
                NSPredicate(format: "%K CONTAINS[c] %@", key, searchString)
            })
        default:
            return nil
        }
    }
    
    var label: String {
        switch self {
        case .patients:
            return "Patients"
        case .diagnostics:
            return "Diagnosis"
        case .physicians:
            return "Physicians"
        case .episodesOfCare:
            return "Episodes of Care"
        case .lists:
            return "Lists"
        }
    }
    
    
    var keyPaths: [String] {
        switch self{
        case .patients:
            return ["name"]
        default:
            return []
        }
    }
    
    var descriptors: [NSSortDescriptor] {
        switch self {
        case .patients:
            return [
                NSSortDescriptor(keyPath: \Patient.name, ascending: true),
                NSSortDescriptor(keyPath: \Patient.ramqNumber, ascending: true)
            ]
        default:
            return []
        }
    }
}
