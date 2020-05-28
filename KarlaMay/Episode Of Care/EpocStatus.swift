//
//  EpocStatus.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-14.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

enum EpocStatus: String, CaseIterable, RawRepresentable, Hashable {
    case inpatient, outpatient, transferred, archived
    
    var label: String{
        switch self {
        case .inpatient:
            return "Inpatient"
        case .outpatient:
            return "Outpatient"
        case .transferred:
            return "Transferred"
        case .archived:
            return "Archived"
        }
    }
    
    var descriptor: [NSSortDescriptor] {
        return []
    }
    
    static func forEpoc(_ epoc:EpisodeOfCare) -> EpocStatus {
        if epoc.isInpatient {return .inpatient}
        if epoc.isArchived {return .archived}
        if epoc.isTransferred {return .transferred}
        return .outpatient
    }
    
    var predicate: NSPredicate {
        
        switch self {
        case .inpatient:
            let inPatient = NSExpression(forKeyPath: \EpisodeOfCare.isInpatient)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        case .outpatient:
            let outPatient = NSExpression(forKeyPath: \EpisodeOfCare.isOutpatient)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: outPatient, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        case .archived:
            let isArchived = NSExpression(forKeyPath: \EpisodeOfCare.isArchived)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: isArchived, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        case .transferred:
            let transferred = NSExpression(forKeyPath: \EpisodeOfCare.isTransferred)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: transferred, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        }
    }
}
