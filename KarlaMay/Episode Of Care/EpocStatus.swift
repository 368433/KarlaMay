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
    
    func update(epoc: EpisodeOfCare){
        switch self {
        case .inpatient:
            epoc.isInpatient = true
            epoc.isActive = true
            epoc.isMine = true
        case .outpatient:
            epoc.isInpatient = false
            epoc.isActive = true
            epoc.isMine = true
        case .archived:
            epoc.isActive = false
        case .transferred:
            epoc.isMine = false
            epoc.isActive = true
        }
    }
    
    var predicate: NSPredicate {
        
        let yes = NSExpression(forConstantValue: true)
        let mine = NSExpression(forKeyPath: \EpisodeOfCare.isMine)
        let inPatient = NSExpression(forKeyPath: \EpisodeOfCare.isInpatient)
        let active = NSExpression(forKeyPath: \EpisodeOfCare.isActive)
        
        let isInPatient = NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .equalTo, options: .init())
        let isOutPatient = NSComparisonPredicate(leftExpression: inPatient, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
        let isMine = NSComparisonPredicate(leftExpression: yes, rightExpression: mine, modifier: .direct, type: .equalTo, options: [])
        let notMine = NSComparisonPredicate(leftExpression: mine, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
        let isActive = NSComparisonPredicate(leftExpression: active, rightExpression: yes, modifier: .direct, type: .equalTo, options: [])
        let isArchived = NSComparisonPredicate(leftExpression: active, rightExpression: yes, modifier: .direct, type: .notEqualTo, options: [])
        
        switch self {
        case .inpatient:
            return NSCompoundPredicate(type: .and, subpredicates: [isInPatient, isActive, isMine])
        case .outpatient:
            return NSCompoundPredicate(type: .and, subpredicates: [isOutPatient, isActive, isMine])
        case .archived:
            return NSCompoundPredicate(type: .and, subpredicates: [isArchived])
        case .transferred:
            return NSCompoundPredicate(type: .and, subpredicates: [isActive, notMine])
        }
    }
}
