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
    @State private var listType = ClinicalWorkStatus.active
    @State private var showClinicalWorkForm = false
    
    var body: some View {
        VStack{
            Picker(selection: $listType, label: Text("List Types")) {
                ForEach(ClinicalWorkStatus.allCases, id: \.self){ list in
                    Text(list.label).tag(list)
                }
            }.pickerStyle(SegmentedPickerStyle())
            ScrollView(.vertical){
                VStack{
                    DynamicFilteredList(sorting: listType.descriptors, predicate: listType.predicate) { (list: ClinicalWork) in
                        NavigationLink(destination: EpisodeOfCareListView(parentList: list)) {
                            ClinicalWorkRowView(clinicalWork: list, isActive: list.isActive)
                        }
                    }
                }.padding([.leading, .trailing])
            }
        }
        
        .sheet(isPresented: $showClinicalWorkForm, content: { ClinicalWorkFormView().environment(\.managedObjectContext, self.moc)})
        .navigationBarTitle("Listes clinique")
        .navigationBarItems(trailing: Button(action:{
            self.showClinicalWorkForm.toggle()
        }){
            Image(systemName: "plus").padding()
        })
    }

}

struct AllClinicalWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AllClinicalWorkView()
    }
}
