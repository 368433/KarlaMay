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
            return diagnoses.sorted()
        } else { return []}
    }
    var chronologicEpisodesOfCare: [EpisodeOfCare] {
        if let diagnoses = self.diagnoses as? Set<EpisodeOfCare> {
            return diagnoses.sorted()
        } else { return []}
    }
}
