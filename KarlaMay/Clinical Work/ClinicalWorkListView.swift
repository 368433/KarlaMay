//
//  ClinicalWorkListView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkListView: View {
    
    var clinicalWork: ClinicalWork
    @Environment(\.managedObjectContext) var moc
    @State private var showDeleteAlert = false
    
    var body: some View {
        List{
            ForEach(self.clinicalWork.chronologicEpisodesOfCare) { eoc in
                NavigationLink(destination: Text("test")) {
                    EpisodeOfCareRowView(episodeOfCare: eoc).environment(\.managedObjectContext, self.moc)
                }
            }.onDelete(perform: deleteRow)
        }
        .alert(isPresented: $showDeleteAlert) { () -> Alert in
            Alert(title: Text("Deleting row"), message: Text("This will permanently remove this element from the record"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                //remove from database
            })
            )
        }
    }
    private func deleteRow(at index: IndexSet) {
        self.showDeleteAlert.toggle()
    }
}

struct ClinicalWorkListView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkListView(clinicalWork: DummyData.dummyClinicalWork)
    }
}
