//
//  SearchView.swift
//  karlaSUI
//
//  Created by quarticAIMBP2018 on 2020-04-28.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presenting
    @State private var searchQuery = ""
    @State private var objectsSearched: SearchableContent = .patients
    
    var body: some View {
//        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Button("Done"){self.presenting.wrappedValue.dismiss()}
                }
                TextField("search", text: $searchQuery).textFieldStyle(RoundedBorderTextFieldStyle())
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(SearchableContent.allCases, id: \.self){ content in
                            Button(action:{self.objectsSearched = content}){
                                Text(content.label).font(.caption).fontWeight(.medium)
                                    .padding(8)
                                    .background(Color.lightSmoke)
                                    .clipShape(Capsule())
                            }
                        }
                    }.padding(10)
                }
                List{
                    DynamicFilteredList(sorting: objectsSearched.descriptors, predicate: objectsSearched.predicates(keypaths: objectsSearched.keyPaths, searchString: searchQuery)) { (pt: Patient) in
                        PatientRow(patient: pt)
                    }.environment(\.managedObjectContext, self.moc)
                }
            }.padding()
                .navigationBarTitle("", displayMode: .inline)
//        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
