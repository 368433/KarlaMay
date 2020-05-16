//
//  TestView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct TestView: View {
    let loginData = LoginDataForWHOICDAPI()
    @State private var tok = WHOICDToken()
    
    var body: some View {
        Group{
            if tok.isValid() {
                Text(tok.value())
            } else {
                Text("invalid token")
            }
        }
        .onAppear(perform: getData)
    }
    
    func getData(){
        requestToken(tokenEndpoint: loginData.tokenEndpoint, grantType: loginData.grantType, clientID: loginData.clientID, clientSecret: loginData.ClientSecret){ token in
            self.tok = WHOICDToken(token: token)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
