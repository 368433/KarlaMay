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
    //    @State var results: NSSet
    //    @ObservedObject var dxResult: ICDresult = ICDresult()
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    
    init(episode: EpisodeOfCare){
        self.episode = episode
        if episode.currentDiagnoses == nil {
            self.episode.currentDiagnoses = []
        }
    }
    
    var body: some View {
        Section(header: HStack {
            Text("Diagnosis").font(.callout)
//            Spacer()
//            Button(action: {self.showICDSearch.toggle()}){AddIcon()}
        }){
            NavigationLink(destination: WHOICDSearch2(results: self.$episode.currentDiagnoses)) {
                Text("Add dx")
            }
            if self.episode.currentDiagnoses!.count == 0 {
                Text("No diagnoses").foregroundColor(.secondary)
            } else {
                ForEach(0..<self.episode.currentDiagnoses!.count, id: \.self){ index in
                    //                DiagnosisRowView(diagnosis: dx)
                    Text("test")
                }.onDelete(perform: deleteDiagnosis)
            }
        }
//        .sheet(isPresented: $showICDSearch){WHOICDSearch2(results: self.$episode.currentDiagnoses).environment(\.managedObjectContext, self.moc)}
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
    }
}

struct DiagnosisSection2_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection2(episode: DummyData.dummyEpisodeOfCare)
    }
}
