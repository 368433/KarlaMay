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
            HStack{
                Text("Clinical Visits").fontWeight(.bold)
                Spacer()
                Button(action:{self.showAddVisit.toggle()}){AddIcon()}
                    .sheet(isPresented: $showAddVisit) {
                        ClinicalVisitForm(){ (visit) in
                            DispatchQueue.main.async {self.episode.addToClinicalVisits(visit)}
                        }.environment(\.managedObjectContext, self.moc)
                }
            }
            if self.episode.clinicalVisits?.count == 0 {
                Text("No clinical visits").foregroundColor(.secondary)
            } else {
                VStack{
                    ForEach(visitList, id: \.self){ visit in
                        ClinicalVisitRowView(clinicalVisit: visit)
                    }
                }
            }
            }.padding().background(Color(UIColor.systemGray6)).cornerRadius(5)
    }
}

struct VisitSection_Previews: PreviewProvider {
    static var previews: some View {
        VisitSection(episode: DummyData.dummyEpisodeOfCare)
    }
}
