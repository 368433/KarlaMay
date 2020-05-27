//
//  WHOICDSearch2.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct WHOICDSearch2: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var searchTerm: String = ""
    @State private var searchQuery: String = ""
    @ObservedObject var token = WHOICDAPIAccessToken()
    @ObservedObject var decoder = WHOICDResponseDecoder()
    @State var endpoint: WHOICDAPIEndpoint = WHOICDAPIEndpoint(query: "")
    //    var completion: (_ entity: ICDDestinationEntity, _ dxList: NSSet?) -> Void
    @State var tokenValue: String = ""
    @Binding var results: NSSet?
    @State var test: Set<Diagnosis> = []
    
    
    //    init(results: NSSet?,completion: @escaping (_ entity: ICDDestinationEntity, _ dxList: NSSet?) -> Void) {
    //        self.completion = completion
    //        self.results = results
    //    }
    //    init(results: NSSet){
    //        self.results = results
    //    }
    
    var body: some View {
        //        NavigationView {
        ScrollView(.vertical){
        VStack(spacing: 0){
            HStack{
                TextField("search WHO ICD-11 database", text: $searchTerm, onCommit: {
                    self.searchQuery = self.searchTerm
                    self.fetchData()
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {self.searchQuery = self.searchTerm ;UIApplication.shared.endEditing()}){
                    Image(systemName: "magnifyingglass").padding(5)
                }
                Button(action:{self.searchTerm.append("%")}){
                    Text("%").foregroundColor(.primary).padding(5)
                }
            }.padding([.leading, .trailing, .top])
//                VStack{
                    ForEach(decoder.results, id:\.self) { destinationEntity in
                        ICDDiagnosisRow(diagnosis: destinationEntity)
                            .onTapGesture {
                                let dx = Diagnosis(context: self.moc)
                                dx.title = destinationEntity.titleStripped
                                dx.icdCode = destinationEntity.theCode
                                self.test.insert(dx)
                                //                            self.results = NSSet(object: dx)
                                //                                self.presentationMode.wrappedValue.dismiss()
                        }
                    }
//                }
            }
        }
            //            }
            .navigationBarTitle("Add Dx", displayMode: .inline)
            //        }
            .onAppear(perform:token.checkValidity)
    }
    private func fetchData(){
        if !self.searchQuery.isEmpty, !token.access.isExpired() {
            self.endpoint = WHOICDAPIEndpoint(query: self.searchQuery)
            self.tokenValue = token.access.value()
            do {
                try auth0APICall(apiEndPoint: endpoint.endPoint(), additionalHeaders: endpoint.additionalHeaders(), accessToken: tokenValue){ data in
                    self.decoder.data = data
                }
            } catch {
                print("error")
            }
        }
    }
}

//struct WHOICDSearch2_Previews: PreviewProvider {
//    static var previews: some View {
//        WHOICDSearch2(completion: {dx in })
//    }
//}
