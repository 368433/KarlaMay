//
//  ExtensionClinicalWork.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

extension ClinicalWork: Identifiable {
    
    var chronologicEpisodesOfCare: [EpisodeOfCare] {
        if let eocs = self.episodesOfCare as? Set<EpisodeOfCare> {
            return eocs.sorted()
        } else { return []}
    }
    
}
