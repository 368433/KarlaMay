//
//  DiagnosisSection2.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-26.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSection2: View {
    @ObservedObject var episode: EpisodeOfCare
    @ObservedObject var dxResult: ICDresult = ICDresult()
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    
    init(episode: EpisodeOfCare){
        self.episode = episode
        self.episode.currentDiagnoses = episode.currentDiagnoses == nil ? []:episode.currentDiagnoses!
    }
    
    var body: some View {
        Section(header: HStack {
            Text("Diagnosis").font(.callout)
            Spacer()
            Button(action: {self.showICDSearch.toggle()}){AddIcon()}
        }){
            if episode.currentDiagnoses?.count == 0 {
                Text("No diagnoses").foregroundColor(.secondary)
            } else {
                ScrollView(.horizontal){
                    VStack{
                        ForEach(0..<self.episode.currentDiagnoses!.count){ index in
                            DiagnosisRowView(diagnosis: self.episode.diagnosisList[index])
                        }.onDelete(perform: deleteDiagnosis)
                    }
                }
            }
        }
        .sheet(isPresented: $showICDSearch){WHOICDSearchView(returnedSearchResults: self.dxResult).environment(\.managedObjectContext, self.moc)}
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
        
    }
}

struct DiagnosisSection2_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection2(episode: DummyData.dummyEpisodeOfCare)
    }
}
