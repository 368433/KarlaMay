//
//  WHOICDSearchResultsList.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct WHOICDSearchResultsList: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var decoder = WHOICDResponseDecoder()
    var endpoint: WHOICDAPIEndpoint
    var token: String
    var returnedResults: ICDresult
    
    init(query: String, token: WHOICDAPIAccessToken, returnedResults: ICDresult) {
        self.endpoint = WHOICDAPIEndpoint(query: query)
        self.token = token.access.value()
        self.returnedResults = returnedResults
        if !query.isEmpty, !token.access.isExpired() {
            fetchData()
        }
    }
    
    var body: some View {
        ForEach(decoder.results) { destinationEntity in
            ICDDiagnosisRow(diagnosis: destinationEntity)
                .onTapGesture {
                    let dx = Diagnosis(context: self.moc)
                    dx.title = destinationEntity.titleStripped
                    dx.icdCode = destinationEntity.theCode
                    self.returnedResults.add(dx)
                    //  try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    private func fetchData(){
        do {
            try auth0APICall(apiEndPoint: endpoint.endPoint(), additionalHeaders: nil, accessToken: token){ data in
                self.decoder.data = data
            }
        } catch {
            print("error")
        }
        
    }
}

//struct WHOICDSearchResultsList_Previews: PreviewProvider {
//    static var previews: some View {
//        WHOICDSearchResultsList()
//    }
//}
