//
//  ModifiedDatePicker.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-28.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ModifiedDatePicker: View {
    @Binding var date: Date
    @State var showDatePicker = false
    
    var body: some View {
        VStack {
            VStack{
                Text("Start Date").foregroundColor(.white).fontWeight(.bold)
                Text((self.date).toString).font(.footnote).fontWeight(.semibold)
            }
            }.padding(5)
            .background(Color(UIColor.systemBlue)).cornerRadius(5).shadow(radius: 1)
            .onTapGesture {
                self.showDatePicker.toggle()
        }
        .sheet(isPresented: $showDatePicker) {
            DatePicker(selection: self.$date, in:...Date(), displayedComponents: .date){Text("Episode start date")}.labelsHidden()
        }
    }
}

//struct ModifiedDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifiedDatePicker(date: Date())
//    }
//}
