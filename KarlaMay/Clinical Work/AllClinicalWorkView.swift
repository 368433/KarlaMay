//
//  AllClinicalWorkView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

enum ListType: CaseIterable {
    case active, archived, starred
}
struct AllClinicalWorkView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: ClinicalWork.entity(), sortDescriptors: [], predicate: nil, animation: nil) var clinicalWork: FetchedResults<ClinicalWork>
    @State private var listType = ListType.active
    
    var body: some View {
        //        NavigationView{
        VStack{
            Picker(selection: $listType, label: Text("List Types")) {
                ForEach(ListType.allCases, id: \.self){ list in
                    Text("one").tag(list)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List{
                ForEach(clinicalWork, id: \.self) { cw in
                    ClinicalWorkRowView(clinicalWork: cw)
                }
            }.listStyle(PlainListStyle())
        }
        .navigationBarTitle("All lists")
        .navigationBarItems(trailing: Button(action:{
            //adding dummy data
            let clinwrk = ClinicalWork(context: self.moc)
            clinwrk.startDate = Date()
            clinwrk.comments = " ut labore et dolore magna aliqua. Ut enim ad minim veniam"
            try? self.moc.save()
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
