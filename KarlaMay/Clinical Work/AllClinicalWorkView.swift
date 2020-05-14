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
//            ScrollView(.vertical){
                VStack{
                    DynamicFilteredList(sorting: listType.descriptors, predicate: listType.predicate) { (list: ClinicalWork) in
                        ClinicalWorkRowView(clinicalWork: list, isMainList: list.isMainList, isActive: list.isActive)
                        
//                        HStack{
//                            VStack(alignment: .leading){
//                                Text(list.title ?? "No title").font(.headline)
//                                Text("Created on: " + (list.startDate?.toString ?? "No date set")).font(.caption).foregroundColor(.secondary)
//                            }
//                            Spacer()
//                            HStack(spacing: 20){
//                                Button(action: {list.toggleMainListStatus(); try? self.moc.save()}){
//                                    if list.isMainList {
//                                        Image(systemName: "star.fill")
//                                    } else {
//                                        Image(systemName: "star").foregroundColor(.secondary)
//                                    }
//                                }.padding(5)
//                                Button(action: {list.toggleActiveStatus(); try? self.moc.save()}){
//                                    if list.isActive {
//                                        Image(systemName: "archivebox")
//                                    } else {
//                                        Image(systemName: "archivebox.fill").foregroundColor(.secondary)
//                                    }
//                                }.padding(5)
//                            }
//                        }
                    }
                    Spacer()
                }.padding([.leading, .trailing])
//            }
        }
            
        .sheet(isPresented: $showClinicalWorkForm, content: { ClinicalWorkFormView().environment(\.managedObjectContext, self.moc)})
        .navigationBarTitle("All lists")
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
