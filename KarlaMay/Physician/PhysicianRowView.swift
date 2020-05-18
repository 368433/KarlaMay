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
        VStack(alignment: .leading){
            Text(physician.name ?? "No name").font(.headline)
            Text(physician.license ?? "No license").foregroundColor(.secondary)
        }
    }
}

//struct PhysicianRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhysicianRowView(physician: DummyData)
//    }
//}
