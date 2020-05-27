//
//  WHOICDSearchView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct WHOICDSearchView: View {
    /*
     intantiate a whoicdtoken, observed object
     feed it to a list view as a parameter
     the list view will make the call to the server or display no result if token is not valid
     **/
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var searchTerm: String = ""
    @State private var searchQuery: String = ""
    @ObservedObject var token = WHOICDAPIAccessToken()
//    var dxResult: ICDresult
//    var results: NSSet
//    @State var results: Set<Diagnosis>
    var completion: (_ dx: Diagnosis) -> Void
//
    init(completion: @escaping (_ dx: Diagnosis) -> Void){
        self.completion = completion
    }
    
//    init(returnedSearchResults: ICDresult){
//        self.dxResult = returnedSearchResults
//    }
//    init(results: NSSet){
//        self.results = results
//    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(spacing: 0){
                    HStack{
                        TextField("search WHO ICD-11 database", text: $searchTerm, onCommit: {self.searchQuery = self.searchTerm})
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {self.searchQuery = self.searchTerm ;UIApplication.shared.endEditing()}){
                            Image(systemName: "magnifyingglass").padding(5)
                        }
                        Button(action:{self.searchTerm.append("%")}){
                            Text("%").foregroundColor(.primary).padding(5)
                        }
                    }.padding([.leading, .trailing, .top])
                    
                    WHOICDSearchResultsList(query: self.searchQuery, token: token){ destinationEntity in
                        let dx = Diagnosis(context: self.moc)
                        dx.title = destinationEntity.titleStripped
                        dx.icdCode = destinationEntity.theCode
                        self.completion(dx)
//                        self.results.adding(dx)
//                        DispatchQueue.main.async {
////                            self.completion(dx)
////                            self.results.insert(dx)
//                            self.dxResult.add(dx)
//                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear(perform:token.checkValidity)
            .navigationBarTitle("Search", displayMode:.inline)
            .navigationBarItems(trailing:
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "xmark.circle").padding()
            })
        }
    }
}

//struct WHOICDSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        WHOICDSearchView(returnedSearchResults: ICDresult())
//    }
//}
