//
//  DiagnosisSectionView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSectionView: View {
    
    @ObservedObject var dxResult: ICDresult
    @Environment(\.managedObjectContext) var moc
    @State private var showICDSearch = false
    
    var body: some View {
        /// DIAGNOSIS
        HStack {
            Color.blue.frame(width: 8)
            VStack(alignment: .leading) {
                HStack {
                    Text("Diagnosis").font(.callout)
                    Spacer()
                    Button(action: {self.showICDSearch.toggle()}){AddIcon()}
                }
                ForEach(dxResult.results, id: \.self){ dx in
                    DiagnosisRowView(diagnosis: dx)
                }.onDelete(perform: deleteDiagnosis)
            }
        }.cornerRadius(5)
//            .sheet(isPresented: $showICDSearch){WHOICDSearchView(returnedSearchResults: self.dxResult).environment(\.managedObjectContext, self.moc)}
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet){
        
    }
}

struct DiagnosisSectionView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSectionView(dxResult: ICDresult())
    }
}
