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
        print("dx section init called")
    }
    
    var body: some View {
        VStack (alignment: .leading){
            if !self.diagnosticList.results.isEmpty{
                Text("Current diagnostic list").foregroundColor(Color.blue).font(.footnote)
            }
            HStack{
                Button(action:{self.showICDSearch.toggle()}){AddIcon()}
                if self.diagnosticList.results.isEmpty {
                    Text("No diagnoses").foregroundColor(.secondary)
                } else {
                    ScrollView(.horizontal){
                        HStack(alignment: .top){
                            ForEach(self.diagnosticList.results, id:\.self){ dx in
                                DiagnosisCompactView(diagnosis: dx)
                            }.onDelete(perform: deleteDiagnosis)
                        }.padding(2)
                    }
                }
            }
            .sheet(isPresented: $showICDSearch) {DiagnosisSearch { (dx) in
                self.diagnosticList.results.append(dx)
            }.environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
    }
}

struct DiagnosisSection2_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSection2(diagnosticList: ICDresult())
    }
}
