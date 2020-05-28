//
//  DiagnosisSection2.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-26.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSection2: View {
    
    @ObservedObject var diagnosticList: ICDresult
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    
    init(diagnosticList: ICDresult){
        self.diagnosticList = diagnosticList
    }
    
    var body: some View {
        
        //            NavigationLink(destination: DiagnosisSearch(completion: { (dx) in
        //                self.episode.currentDiagnoses = NSSet(object: dx)
        //            })) {
        //                Text("Add dx")
        //            }
        HStack{
            Button(action:{self.showICDSearch.toggle()}){AddIcon()}
            if self.diagnosticList.results.isEmpty {
                Text("No diagnoses").foregroundColor(.secondary)
            } else {
                ScrollView(.horizontal){
                    ForEach(self.diagnosticList.results, id:\.self){ dx in
                        //                DiagnosisRowView(diagnosis: dx)
                        Text("test")
                    }.onDelete(perform: deleteDiagnosis)
                }
            }
        }
        .sheet(isPresented: $showICDSearch) {DiagnosisSearch { (dx) in
            self.diagnosticList.results.append(dx)
        }.environment(\.managedObjectContext, self.moc)
        }
        //        .sheet(isPresented: $showICDSearch){WHOICDSearch2(results: self.$episode.currentDiagnoses).environment(\.managedObjectContext, self.moc)}
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
    }
}

struct DiagnosisSection2_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection2(diagnosticList: ICDresult())
    }
}
