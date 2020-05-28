//
//  VisitSection.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct VisitSection: View {
    
    @ObservedObject var episode: EpisodeOfCare
    @Environment(\.managedObjectContext) var moc
    @State private var showAddVisit = false
    var visitList: [ClinicalVisit] = []
    
    init(episode: EpisodeOfCare){
        self.episode = episode
        if let visitList = episode.clinicalVisits as? Set<ClinicalVisit> {
            self.visitList = Array(visitList).sorted()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            //label to show if list is not empty
            if self.episode.clinicalVisits?.count != 0 {
                Text("Visit list").foregroundColor(.blue).font(.footnote)
            }
            HStack(alignment:.top){
                
                //button to add
                Button(action:{self.showAddVisit.toggle()}){AddIcon()}
                .sheet(isPresented: $showAddVisit) {
                    ClinicalVisitForm(){ (visit) in self.episode.addToClinicalVisits(visit) }.environment(\.managedObjectContext, self.moc)
                }
                
                //list of clinical visit
                VStack {
                    List{
                        if self.episode.clinicalVisits?.count == 0 {
                            Text("No clinical visits").foregroundColor(.secondary)
                        } else {
                            ForEach(visitList, id: \.self){ visit in
                                ClinicalVisitRowView(clinicalVisit: visit)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct VisitSection_Previews: PreviewProvider {
    static var previews: some View {
        VisitSection(episode: DummyData.dummyEpisodeOfCare)
    }
}
