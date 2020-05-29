//
//  DiagnosisSection3.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSection3: View {
    
    @Binding var diagnosticList: [Diagnosis]
    //    @ObservedObject var episode: EpisodeOfCare
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    //    var diagnosticList: [Diagnosis]
    
    //    init(episode: EpisodeOfCare){
    //        self.episode = episode
    //        if let diagnosticList = episode.currentDiagnoses as? Set<Diagnosis> {
    //            self.diagnosticList = Array(diagnosticList).sorted()
    //        } else { self.diagnosticList = []}
    //    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("Diagnosis").fontWeight(.heavy)
                Button(action:{self.showICDSearch.toggle()}){Image(systemName: "plus").renderingMode(.original)}.padding()
            }
            if self.diagnosticList.isEmpty {
                Text("No diagnoses").foregroundColor(.secondary)
            } else {
                VStack(alignment: .leading){
                    ForEach(self.diagnosticList, id:\.self){ dx in
                        DiagnosisCompactView(diagnosis: dx)
                    }
                }
                .sheet(isPresented: $showICDSearch) {DiagnosisSearch { (dx) in
                    self.diagnosticList.append(dx)
                    //                    self.episode.addToCurrentDiagnoses(dx)
                }.environment(\.managedObjectContext, self.moc)
                }
            }
        }
    }
}

struct DiagnosisSection3_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection3(diagnosticList: .constant([]))
    }
}
