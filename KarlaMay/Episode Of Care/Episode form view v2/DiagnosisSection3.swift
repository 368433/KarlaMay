//
//  DiagnosisSection3.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSection3: View {
    
    @ObservedObject var episode: EpisodeOfCare
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    var diagnosticList: [Diagnosis]
    
    init(episode: EpisodeOfCare){
        self.episode = episode
        if let diagnosticList = episode.currentDiagnoses as? Set<Diagnosis> {
            self.diagnosticList = Array(diagnosticList).sorted()
        } else { self.diagnosticList = []}
    }
    
    var body: some View {
        Section(header: HStack{
            Text("Diagnostic list")
            Spacer()
            Button(action:{self.showICDSearch.toggle()}){AddIcon()}
        }) {
            HStack{
                if self.episode.currentDiagnoses?.count == 0 {
                    Text("No diagnoses").foregroundColor(.secondary)
                } else {
                    ScrollView(.horizontal){
                        HStack(alignment: .top){
                            ForEach(self.diagnosticList, id:\.self){ dx in
                                DiagnosisCompactView(diagnosis: dx)
                            }.onDelete(perform: deleteDiagnosis)
                        }.padding(2)
                    }
                }
            }
            .sheet(isPresented: $showICDSearch) {DiagnosisSearch { (dx) in
                self.episode.addToCurrentDiagnoses(dx)
            }.environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
    }
    
}

struct DiagnosisSection3_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection3(episode: DummyData.dummyEpisodeOfCare)
    }
}
