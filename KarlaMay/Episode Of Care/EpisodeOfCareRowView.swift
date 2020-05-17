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
            Group{
                Text(episodeOfCare.patient?.name ?? "No patient Name").font(.headline)
                HStack{
                    Text("Age")
                    Text("Room")
                    }.foregroundColor(.primary).font(.caption)
                Text(episodeOfCare.episodeLabel).foregroundColor(.secondary)
            }.lineLimit(1)
            if episodeOfCare.clinicalVisits?.count != 0 {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(episodeOfCare.sortedVisits, id: \.self){ visit in
                            ClinicalVisitDotView(visit: visit)
                        }
                    }
                }
            }
        }
        .contextMenu {
            VStack{
                ForEach(EpocStatus.allCases, id: \.self){ status in
                    Button(status.label){
                        self.episodeOfCare.setStatus(to: status)
                    }
                }
            }
        }
        .onTapGesture {self.showEditEpoc.toggle()}
        .sheet(isPresented: $showEditEpoc) {
            EpisodeOfCareForm(epoc: self.episodeOfCare).environment(\.managedObjectContext, self.moc)
        }
    }
}

struct EpisodeOfCareRowView_Previews: PreviewProvider {
    static var previews: some View {
        return EpisodeOfCareRowView(episodeOfCare: DummyData.dummyEpisodeOfCare)
    }
}
