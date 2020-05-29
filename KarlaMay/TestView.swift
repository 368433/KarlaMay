//
//  TestView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @State var date: Date = Date()
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                Form{
                    DatePicker(selection: $date, label: {Text("test")})
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
