//
//  ExtentsionPatient.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

extension Patient {
    func hasNoDx() -> Bool {
        return self.diagnoses?.count == 0 ? true:false
    }
    var chronologicDiagnoses: [Diagnosis] {
        if let diagnoses = self.diagnoses as? Set<Diagnosis> {
            return diagnoses.sorted { (dx1, dx2) -> Bool in
                guard let date1 = dx1.startDate else { return false}
                guard let date2 = dx2.startDate else { return true}
                return date1 < date2
            }
        } else { return []}
    }
    var chronologicEpisodesOfCare: [EpisodeOfCare] {
        if let diagnoses = self.diagnoses as? Set<EpisodeOfCare> {
            return diagnoses.sorted { (eoc1, eoc2) -> Bool in
                guard let date1 = eoc1.startDate else { return false}
                guard let date2 = eoc2.startDate else { return true}
                return date1 < date2
            }
        } else { return []}
    }
}
