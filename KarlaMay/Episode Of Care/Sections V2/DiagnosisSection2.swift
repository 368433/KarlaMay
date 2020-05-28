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
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    
    init(episode: EpisodeOfCare){
        self.episode = episode
        if episode.currentDiagnoses == nil {
            self.episode.currentDiagnoses = []
        }
    }
    
    var body: some View {
        
        //            NavigationLink(destination: DiagnosisSearch(completion: { (dx) in
        //                self.episode.currentDiagnoses = NSSet(object: dx)
        //            })) {
        //                Text("Add dx")
        //            }
        HStack{
            Button(action:{}){AddIcon()}
            if self.episode.currentDiagnoses!.count == 0 {
                Text("No diagnoses").foregroundColor(.secondary)
            } else {
                ScrollView(.horizontal){
                    ForEach(0..<self.episode.currentDiagnoses!.count, id: \.self){ index in
                        //                DiagnosisRowView(diagnosis: dx)
                        Text("test")
                    }.onDelete(perform: deleteDiagnosis)
                }
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
