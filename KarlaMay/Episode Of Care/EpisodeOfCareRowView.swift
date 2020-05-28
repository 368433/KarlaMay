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
    
    @Environment(\.managedObjectContext) var moc
    var episodeOfCare: EpisodeOfCare
    @State private var showEditEpoc = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text(episodeOfCare.patient?.name ?? "No patient Name").font(.headline)
                .lineLimit(1)
        }
        .onTapGesture {self.showEditEpoc.toggle()}
        .sheet(isPresented: $showEditEpoc) {
            EpisodeOfCareForm2(episodeToEdit: self.episodeOfCare, parentList: nil).environment(\.managedObjectContext, self.moc)
        }
    }
}

struct EpisodeOfCareRowView_Previews: PreviewProvider {
    static var previews: some View {
        return EpisodeOfCareRowView(episodeOfCare: DummyData.dummyEpisodeOfCare)
    }
}
