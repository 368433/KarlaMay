//
//  EpisodeOfCareRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

struct EpisodeOfCareRowView: View {
    
    var episodeOfCare: EpisodeOfCare
    
    var body: some View {
        VStack(alignment: .leading){
            Group{
                Text(episodeOfCare.patient?.name ?? "No patient Name").font(.headline)
                Text(episodeOfCare.episodeLabel).foregroundColor(.secondary)
            }.lineLimit(1)
            ScrollView(.horizontal){
                HStack{
                    ForEach(episodeOfCare.sortedVisits, id: \.self){ visit in
                        ClinicalVisitDotView(visit: visit)
                    }
                }
            }
        }
    }
}

struct EpisodeOfCareRowView_Previews: PreviewProvider {
    static var previews: some View {
        return EpisodeOfCareRowView(episodeOfCare: DummyData.dummyEpisodeOfCare)
    }
}
