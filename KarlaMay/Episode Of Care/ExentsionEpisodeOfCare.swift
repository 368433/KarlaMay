//
//  ExentsionEpisodeOfCare.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

extension EpisodeOfCare : Dated, Identifiable {
    var episodeLabel: String {
        guard let diagnosis = self.currentDiagnoses as? Set<Diagnosis> else { return "Missing associated diagnosis"}
        return diagnosis.first?.title ?? "Diagnosis missing a title"
    }
    var dateLabel: String {
        guard let date = self.startDate else { return "Missing start date"}
        return date.toString
    }
    
    var sortedVisits: [ClinicalVisit] {
        guard let visits = self.clinicalVisits as? Set<ClinicalVisit> else { return []}
        return visits.sorted()
    }
    
    var epocStatus: EpocStatus {
        get{
            return EpocStatus.forEpoc(self)
        }
        set{
            self.setStatus(to: newValue)
        }
    }
    
    func setStatus(to status: EpocStatus){
        switch status {
        case .inpatient:
            self.isInpatient = true
            self.isArchived = false
            self.isTransferred = false
        case .outpatient:
            self.isInpatient = false
            self.isArchived = false
            self.isTransferred = false
        case .archived:
            self.isInpatient = false
            self.isArchived = true
            self.isTransferred = false
        case .transferred:
            self.isInpatient = false
            self.isArchived = false
            self.isTransferred = true
        }
    }
}
