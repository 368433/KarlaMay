//
//  AddIcon.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct AddIcon: View {
    var body: some View {
        Image(systemName: "plus.rectangle.fill").font(.system(size: 24))
    }
}

struct AddIcon_Previews: PreviewProvider {
    static var previews: some View {
        AddIcon()
    }
}
