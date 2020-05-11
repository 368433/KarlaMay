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
    var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    var dummyDiagnosis: Diagnosis {
        let dx = Diagnosis(context: moc)
        dx.title = "Pneumonia"
        dx.icdCode = "A23.2"
        dx.startDate = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 340000...2020000)))
        dx.endDate = Date(timeIntervalSinceNow: 3600)
        return dx
    }
    
    var dummyEpisodeOfCare: EpisodeOfCare {
        let eoc = EpisodeOfCare(context: moc)
        eoc.startDate = Date()
        return eoc
    }
}
