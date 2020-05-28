//
//  DiagnosisSearch.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisSearch: View {
    
    var completion: (_ diagnosis: Diagnosis) -> Void
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var token = WHOICDAPIAccessToken()
    @State private var searchQuery = ""
    @State private var showManualMDEntry = false
    let dxTitle = NSExpression(forKeyPath: \Diagnosis.title)
    
    init(completion: @escaping (_ diagnosis: Diagnosis)->Void){
        self.completion = completion
    }
    
    var body: some View {
//        VStack{
            List{
                TextField("Search database", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top,.bottom])
                HStack(alignment: .center) {
                    Image(systemName: "plus")
                    Text("Add manual entry").font(.headline)
                }.onTapGesture {
                    self.showManualMDEntry.toggle()
                }.sheet(isPresented: $showManualMDEntry) {
                    Text("test")
//                    PhysicianForm().environment(\.managedObjectContext, self.moc)
                }
                Section(header: Text("Local results")){
                    DynamicFilteredList(sorting: [NSSortDescriptor(keyPath: \Diagnosis.title, ascending: true)], predicate: searchQuery.isEmpty ? nil : NSComparisonPredicate(leftExpression: dxTitle, rightExpression: NSExpression(forConstantValue: self.searchQuery),modifier: .direct, type: .contains )) { (diagnosis: Diagnosis) in
                        DiagnosisRowView(diagnosis: diagnosis)
                            .onTapGesture {
                                self.completion(diagnosis)
                                self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                Section(header: Text("WHO ICD 11 search")){
                    WHOICDSearchResultsList(query: self.searchQuery, token: token) { (entity) in
                        let dx = Diagnosis(context: self.moc)
                        dx.title = entity.title
                        dx.icdCode = entity.theCode
                        self.completion(dx)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }.listStyle(GroupedListStyle())
//        }
            .navigationBarTitle("Search for physician", displayMode: .inline)
    }
}

struct DiagnosisSearch_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisSearch { dx in }
    }
}
