//
//  LinedTextField.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-28.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct LinedTextField: View {
    @Binding var text: String
    var title: String
    var isRequired: Bool
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            if !self.text.isEmpty{
                Text(title.capitalized).font(.caption).foregroundColor(.secondary)
            } else if isRequired {
                    Text("required".capitalized).font(.footnote).foregroundColor(.red)
            }
            
            HStack{
                TextField(title, text: $text)
            }
//            Rectangle().frame(height: 0.5).background(Color(UIColor.quaternaryLabel))
        }
    }
}

struct LinedTextField_Previews: PreviewProvider {
    static var previews: some View {
        LinedTextField(text: .constant(""), title: "Name", isRequired: false)
    }
}
