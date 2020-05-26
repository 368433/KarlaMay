//
//  PhysicianList.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-17.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PhysicianList: View {
    
    var completion: (_ physician: Physician?) -> Void
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var searchQuery = ""
    @State private var showManualMDEntry = false
    let mdName = NSExpression(forKeyPath: \Physician.name)
    
    init(completion: @escaping (_ physician: Physician?)->Void){
        self.completion = completion
    }
    
    var body: some View {
//        NavigationView{
            VStack{
                TextField("Search saved database", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                List{
                    
                    HStack(alignment: .center) {
                        Image(systemName: "plus")
                        Text("Add manual entry").font(.headline)
                    }.onTapGesture {
                        self.showManualMDEntry.toggle()
                    }.sheet(isPresented: $showManualMDEntry) {
                        PhysicianForm().environment(\.managedObjectContext, self.moc)
                    }
                    
                    DynamicFilteredList(sorting: [NSSortDescriptor(keyPath: \Physician.name, ascending: true)], predicate: searchQuery.isEmpty ? nil : NSComparisonPredicate(leftExpression: mdName, rightExpression: NSExpression(forConstantValue: self.searchQuery),modifier: .direct, type: .contains )) { (md: Physician) in
                        PhysicianRowView(physician: md)
                            .onTapGesture {
                                self.completion(md)
                                self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }.listStyle(PlainListStyle())
            }.padding()
                .navigationBarTitle("Search for physician", displayMode: .inline)
    }
}

struct PhysicianList_Previews: PreviewProvider {
    static var previews: some View {
        PhysicianList(completion: {md in})
    }
}
