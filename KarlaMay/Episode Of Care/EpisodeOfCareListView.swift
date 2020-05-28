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
    
    private var filterPredicate: NSPredicate {
        guard let parent = parentList else { return epocStatus.predicate}
        let list = NSExpression(forKeyPath: \EpisodeOfCare.clinicalWork )
        let forParent = NSExpression(forConstantValue: parent)
        let listPredicate = NSComparisonPredicate(leftExpression: list, rightExpression: forParent, modifier: .direct, type: .equalTo, options: [])
        return NSCompoundPredicate(andPredicateWithSubpredicates: [epocStatus.predicate, listPredicate])
    }
    
    init(parentList: ClinicalWork?){
        self.parentList = parentList
    }
    
    var body: some View {
        VStack{
            Picker(selection: $epocStatus, label: Text("Status")) {
                ForEach(EpocStatus.allCases, id: \.self){ status in
                    Text(status.label).tag(status)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List{
                DynamicFilteredList(sorting: [], predicate: filterPredicate) { (epoc: EpisodeOfCare) in
                    EpisodeOfCareRowView(episodeOfCare: epoc)
                    .contextMenu {
                        VStack{
                            ForEach(EpocStatus.allCases, id: \.self){ status in
                                Button(status.label){
                                    epoc.setStatus(to: status)
                                }
                            }
                        }
                    }
                }
            }.id(UUID()).listStyle(PlainListStyle())
        }
        .navigationBarTitle("Work cards")
        .navigationBarItems(trailing: Button(action: {self.showEpocForm.toggle()}){Image(systemName: "plus").padding()})
        .sheet(isPresented: $showEpocForm) {
            EpisodeOfCareForm2(episodeToEdit: nil, parentList: self.parentList).environment(\.managedObjectContext, self.moc)
        }
    }
}


struct EpisodeOfCareListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareListView(parentList: nil)
    }
}
