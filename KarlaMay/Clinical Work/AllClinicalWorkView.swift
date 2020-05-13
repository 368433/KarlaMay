//
//  AllClinicalWorkView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI


struct AllClinicalWorkView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: ClinicalWork.entity(), sortDescriptors: [], predicate: nil, animation: nil) var clinicalWork: FetchedResults<ClinicalWork>
    @State private var listType = ClinicalWorkStatus.active
    @State private var showClinicalWorkForm = false
    
    var body: some View {
        VStack{
            Picker(selection: $listType, label: Text("List Types")) {
                ForEach(ClinicalWorkStatus.allCases, id: \.self){ list in
                    Text(list.label).tag(list)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List{
                ForEach(clinicalWork, id: \.self) { cw in
                    ClinicalWorkRowView(clinicalWork: cw)
                }.onDelete(perform: deleteClinicalWorkItem)
            }.listStyle(PlainListStyle())
        }
        .sheet(isPresented: $showClinicalWorkForm, content: { ClinicalWorkFormView().environment(\.managedObjectContext, self.moc)})
        .navigationBarTitle("All lists")
        .navigationBarItems(trailing: Button(action:{
            self.showClinicalWorkForm.toggle()
        }){
            Image(systemName: "plus").padding()
        })
    }
    private func deleteClinicalWorkItem(at indices: IndexSet) {
        for index in indices {
            self.moc.delete(clinicalWork[index])
        }
    }
}

struct AllClinicalWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AllClinicalWorkView()
    }
}
