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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
