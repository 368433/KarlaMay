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
            HStack{
                Text("Start Date").foregroundColor(.white).fontWeight(.bold)
                Spacer()
                Text((self.date).toString)
            }
            if showDatePicker {
                DatePicker(selection: $date, in:...Date(), displayedComponents: .date){Text("Episode start date")}.labelsHidden()
            }
        }.padding()//.animation(.easeInOut(duration: 0.5))
            .background(Color(UIColor.systemGray6)).cornerRadius(5)
        .onTapGesture {
            self.showDatePicker.toggle()
        }
    }
}

//struct ModifiedDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifiedDatePicker(date: Date())
//    }
//}
