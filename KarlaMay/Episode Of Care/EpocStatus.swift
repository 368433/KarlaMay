//
//  EpocStatus.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-14.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

enum EpocStatus: String, CaseIterable, RawRepresentable, Hashable {
    case inpatient, outpatient, archived, transferred
    
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
        
//        let status = NSExpression(forKeyPath: \EpisodeOfCare.status)
//        let value = NSExpression(forConstantValue: self.rawValue)
//        return NSComparisonPredicate(leftExpression: value, rightExpression: status, modifier: .direct, type: .equalTo, options: [])
        
        switch self {
        case .inpatient:
            let inPatient = NSExpression(forKeyPath: \EpisodeOfCare.isInpatient)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        case .outpatient:
            let inPatient = NSExpression(forKeyPath: \EpisodeOfCare.isInpatient)
            let isArchived = NSExpression(forKeyPath: \EpisodeOfCare.isArchived)
            let transferred = NSExpression(forKeyPath: \EpisodeOfCare.isTransferred)
            let no = NSExpression(forConstantValue: false)
            let notInpatient = NSComparisonPredicate(leftExpression: inPatient, rightExpression: no, modifier: .direct, type: .equalTo, options: [])
            let notArchived = NSComparisonPredicate(leftExpression: isArchived, rightExpression: no, modifier: .direct, type: .equalTo, options: [])
            let notTransferred = NSComparisonPredicate(leftExpression: transferred, rightExpression: no, modifier: .direct, type: .equalTo, options: [])
            return NSCompoundPredicate(andPredicateWithSubpredicates: [notArchived, notInpatient, notTransferred])
        case .archived:
            let isArchived = NSExpression(forKeyPath: \EpisodeOfCare.isArchived)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: isArchived, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        case .transferred:
            let transferred = NSExpression(forKeyPath: \EpisodeOfCare.isTransferred)
            let yes = NSExpression(forConstantValue: true)
            return NSComparisonPredicate(leftExpression: transferred, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        }
        
//        let yes = NSExpression(forConstantValue: true)
//        let mine = NSExpression(forKeyPath: \EpisodeOfCare.isMine)
//        let inPatient = NSExpression(forKeyPath: \EpisodeOfCare.isInpatient)
//        let active = NSExpression(forKeyPath: \EpisodeOfCare.isActive)
//
//        let isMine = NSComparisonPredicate(leftExpression: yes, rightExpression: mine, modifier: .direct, type: .equalTo, options: [])
//        let isActive = NSComparisonPredicate(leftExpression: active, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
//
//        switch self {
//        case .inpatient:
//            let isInPatient = NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .equalTo, options: .init())
//            return NSCompoundPredicate(type: .and, subpredicates: [isInPatient, isActive, isMine])
//        case .outpatient:
//            let isOutPatient = NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
//            return NSCompoundPredicate(type: .and, subpredicates: [isOutPatient, isActive, isMine])
//        case .archived:
//            let isArchived = NSComparisonPredicate(leftExpression: active, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
//            return NSCompoundPredicate(type: .and, subpredicates: [isArchived])
//        case .transferred:
//            let notMine = NSComparisonPredicate(leftExpression: mine, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
//            return NSCompoundPredicate(type: .and, subpredicates: [isActive, notMine])
//        }
    }
}
