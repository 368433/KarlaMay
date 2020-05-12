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
        return eoc
    }
    
    static var dummyClinicalVisit: ClinicalVisit {
        let visit = ClinicalVisit(context: moc)
        visit.startDate = Date()
        visit.actType = "VP 916034343"
        return visit
    }
}
