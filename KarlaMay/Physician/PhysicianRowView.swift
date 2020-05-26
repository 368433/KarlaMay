//
//  PhysicianRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-17.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PhysicianRowView: View {
    
    var physician: Physician
    var body: some View {
        HStack(alignment: .center){
            Text(physician.name ?? "No name").font(.headline)
            Spacer()
            Text(physician.license ?? "No license").foregroundColor(.secondary)
        }
    .contentShape(Rectangle())
    }
}

//struct PhysicianRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhysicianRowView(physician: DummyData)
//    }
//}
