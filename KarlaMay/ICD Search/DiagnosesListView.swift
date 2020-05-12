//
//  DiagnosesListView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosesListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Diagnosis.entity(), sortDescriptors: []) var diagnoses: FetchedResults<Diagnosis>
    @State private var showSearch = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(diagnoses, id: \.self) { dx in
                    Text(dx.title ?? "unknown")
                }
            }
        .navigationBarItems(trailing:
            Button(action: {self.showSearch.toggle()}){
                Image(systemName: "plus.circle").padding()
        }.sheet(isPresented: $showSearch) {
            ICDSearchResultsView().environment(\.managedObjectContext, self.moc)
        })
        }
    }
}

struct DiagnosesListView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosesListView()
    }
}
