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
    
    var body: some View {
        VStack{
            Picker(selection: $epocStatus, label: Text("Status")) {
                ForEach(EpocStatus.allCases, id: \.self){ status in
                    Text(status.label).tag(status)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List{
                DynamicFilteredList(sorting: epocStatus.descriptor, predicate: epocStatus.predicate) { (epoc: EpisodeOfCare) in
                    EpisodeOfCareRowView(episodeOfCare: epoc)
                }
            }.listStyle(PlainListStyle())
        }
        .navigationBarItems(trailing: Button("Add"){self.showEpocForm.toggle()})
        .sheet(isPresented: $showEpocForm) {
            EpisodeOfCareForm().environment(\.managedObjectContext, self.moc)
        }
    }
}


struct EpisodeOfCareListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareListView()
    }
}
