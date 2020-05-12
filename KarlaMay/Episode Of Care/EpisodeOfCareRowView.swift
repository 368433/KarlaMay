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
            Text(episodeOfCare.episodeLabel).foregroundColor(.primary)
            Text(episodeOfCare.dateLabel).foregroundColor(.secondary)
        }
    }
}

struct EpisodeOfCareRowView_Previews: PreviewProvider {
    static var previews: some View {
        return EpisodeOfCareRowView(episodeOfCare: DummyData.dummyEpisodeOfCare)
    }
}
