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
    
    var request: FetchedResults<ClinicalWork> {
        let request = FetchRequest<ClinicalWork>(entity: ClinicalWork.entity(), sortDescriptors: [], predicate: nil, animation: nil)
        return request.wrappedValue
        //return @FetchRequest(entity: ClinicalWork.entity(), sortDescriptors: [], predicate: nil, animation: nil) var clinicalWork: FetchedResults<ClinicalWork>
    }
}
