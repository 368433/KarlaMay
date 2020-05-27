//
//  ExtentsionPatient.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

extension Patient {
    var wrappedName: String {
        get{
            return self.name ?? ""
        }
        set {
            self.name = newValue
        }
    }
    
    func hasNoDx() -> Bool {
        return self.diagnoses?.count == 0 ? true:false
    }
    func hasNoEOC() -> Bool {
        return self.episodesOfCare?.count == 0 ? true:false
    }
    func hasNoVisits() -> Bool {
        return self.clinicalVisits?.count == 0 ? true:false
    }
    var chronologicDiagnoses: [Diagnosis] {
        if let diagnoses = self.diagnoses as? Set<Diagnosis> {
            return diagnoses.sorted()
        } else { return []}
    }
    var chronologicEpisodesOfCare: [EpisodeOfCare] {
        if let eocs = self.episodesOfCare as? Set<EpisodeOfCare> {
            return eocs.sorted()
        } else { return []}
    }
    var chronologicClinicalVisits: [ClinicalVisit] {
        if let visits = self.clinicalVisits as? Set<ClinicalVisit> {
            return visits.sorted()
        } else { return []}
    }
    
    var nameLabel: String { return self.name ?? "No name" }
    var ageSex: String { return self.dateOfBirth?.toString ?? "no date of birth" }
    var location: String { return "Milburn"}
}
