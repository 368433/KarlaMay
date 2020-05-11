//
//  ContentView.swift
//  ICDLookup
//
//  Created by quarticAIMBP2018 on 2020-05-09.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ICDSearchResultsView: View {
    var icdSearch = ICDLinearizationSearch()
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var searchTerm: String = ""
    @State private var searchResults: [ICDDestinationEntity] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(spacing: 0){
                    HStack{
                        TextField("search WHO ICD-11 database", text: $searchTerm, onCommit: {self.GetSearchRequest()})
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {self.GetSearchRequest()
                            UIApplication.shared.endEditing()}){
                            Image(systemName: "magnifyingglass").padding(5)
                        }
                        Button(action:{self.searchTerm.append("%")}){
                            Text("%").foregroundColor(.primary).padding(5)
                        }
                    }.padding([.leading, .trailing, .top])
                    Text(searchResults.count >= 1 ? "\(searchResults.count) results found" : "No results").font(.caption)
                
                    ForEach(searchResults){ result in
                        ICDDiagnosisRow(diagnosis: result)
                            .onTapGesture {
                                let dx = Diagnosis(context: self.moc)
                                dx.title = result.titleStripped
                                dx.icdCode = result.theCode
                                try? self.moc.save()
                                self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "xmark.circle").padding()
            })
        }
    }
    private func GetSearchRequest(){
        do{
            try self.icdSearch.search(query: self.searchTerm) { (resultList) in
                self.searchResults = resultList.sortedResults
            }
        } catch {
            print(error)
        }
    }
}

struct ICDSearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ICDSearchResultsView()
    }
}
