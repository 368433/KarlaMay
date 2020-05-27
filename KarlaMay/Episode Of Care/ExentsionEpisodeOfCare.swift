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
    var diagnosisList: [Diagnosis] {
        guard let dxList = self.currentDiagnoses as? Set<Diagnosis> else {return []}
        return dxList.sorted()
    }
    
    var epocStatus: EpocStatus {
        get{
            return EpocStatus.forEpoc(self)
        }
        set{
            self.setStatus(to: newValue)
        }
    }
    
    var notReadyToSave: Bool {
        guard let pt = self.patient else {return true}
        guard let name = pt.name else {return true}
        return name.isEmpty
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
