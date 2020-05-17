//
//  DummyData.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation
import CoreData

struct DummyData {
    static var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var dummyDiagnosis: Diagnosis {
        let dx = Diagnosis(context: moc)
        dx.title = "Pneumonia"
        dx.icdCode = "B23.2"
        dx.startDate = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 340000...2020000)))
        dx.endDate = Date(timeIntervalSinceNow: 3600)
        return dx
    }
    
    static var dummyEpisodeOfCare: EpisodeOfCare {
        let eoc = EpisodeOfCare(context: moc)
        eoc.startDate = Date()
//        eoc.patient = DummyData.dummyPatient
//        eoc.diagnosis = DummyData.dummyDiagnosis
        eoc.addToClinicalVisits(DummyData.dummyClinicalVisit)
        return eoc
    }
    
    static var dummyClinicalVisit: ClinicalVisit {
        let visit = ClinicalVisit(context: moc)
        visit.startDate = Date()
        visit.actType = "VP"
        return visit
    }
    
    static var dummyPatient: Patient {
        let pt = Patient(context: moc)
        let visit = DummyData.dummyClinicalVisit
        let eoc = DummyData.dummyEpisodeOfCare
        pt.name = "bob"
        pt.addToEpisodesOfCare(eoc)
        pt.addToClinicalVisits(visit)
        pt.addToDiagnoses(DummyData.dummyDiagnosis)
        return pt
    }
    
    static var dummyClinicalWork: ClinicalWork {
        let wrk = ClinicalWork(context: moc)
        wrk.isActive = true
        wrk.isMainList = true
        wrk.startDate = Date()
        wrk.addToEpisodesOfCare(DummyData.dummyEpisodeOfCare)
        wrk.comments = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        return wrk
    }
}
