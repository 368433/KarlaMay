//
//  TestView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var token = WHOICDAPIAccessToken()
    
    var body: some View {
        Text(token.access.value())
    }
}

class WHOICDAPIAccessToken: ObservableObject {
    private let loginData = LoginDataForWHOICDAPI()
    @Published var access = WHOICDToken()
    
    init(){
        checkValidity()
    }
    
    func checkValidity(){
        if access.isExpired() {
            updateToken()
        }
    }
    
    private func updateToken(){
        auth0TokenRequest(tokenEndpoint: loginData.tokenEndpoint, grantType: loginData.grantType, clientID: loginData.clientID, clientSecret: loginData.ClientSecret){ token in
            self.access = WHOICDToken(token: token)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
