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
    @State private var token = ICDAPIToken()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: getData)
    }
    
    func getData(){
        requestToken(tokenEndpoint: loginData.tokenEndpoint, grantType: loginData.grantType, clientID: loginData.clientID, clientSecret: loginData.ClientSecret){_ in
            self.token = token
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
