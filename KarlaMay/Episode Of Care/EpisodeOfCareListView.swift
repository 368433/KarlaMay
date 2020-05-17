//
//  EpisodeOfCareListView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-14.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpisodeOfCareListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var epocStatus = EpocStatus.inpatient
    @State private var showEpocForm = false
    @State private var showEditEpocForm = false
    var parentList: ClinicalWork?
    
    var body: some View {
        VStack{
            Picker(selection: $epocStatus, label: Text("Status")) {
                ForEach(EpocStatus.allCases, id: \.self){ status in
                    Text(status.label).tag(status)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List{
                DynamicFilteredList(sorting: [], predicate: epocStatus.predicate) { (epoc: EpisodeOfCare) in
                    EpisodeOfCareRowView(episodeOfCare: epoc)
                }
            }.id(UUID()).listStyle(PlainListStyle())
        }
        .navigationBarTitle("Work cards")
        .navigationBarItems(trailing: Button(action: {self.showEpocForm.toggle()}){Image(systemName: "plus").padding()})
        .sheet(isPresented: $showEpocForm) {
            EpisodeOfCareForm(parentList: self.parentList).environment(\.managedObjectContext, self.moc)
        }
    }
}


struct EpisodeOfCareListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareListView()
    }
}
