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
        guard let diagnosis = self.diagnosis else { return "Missing associated diagnosis"}
        return diagnosis.title ?? "Diagnosis missing a title"
    }
    var dateLabel: String {
        guard let date = self.startDate else { return "Missing start date"}
        return date.toString
    }
    
    var sortedVisits: [ClinicalVisit] {
        guard let visits = self.clinicalVisits as? Set<ClinicalVisit> else { return []}
        return visits.sorted()
    }
}
