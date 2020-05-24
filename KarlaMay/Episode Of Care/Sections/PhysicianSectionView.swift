//
//  PhysicianSectionView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

//import SwiftUI
//
//struct PhysicianSectionView: View {
//    
//    @ObservedObject var physician: Physician
//    @Environment(\.managedObjectContext) var moc
//    @State private var showPhysiciansList = false
//    
//    var body: some View {
//        HStack {
//            Color.red.frame(width:10)
//            VStack(alignment: .leading){
//                HStack{
//                    Text("Consulting Physician")
//                    Spacer()
//                    Button(action: {self.showPhysiciansList.toggle()}){AddIcon()}
//                }
//                PhysicianRowView(physician: physician)
//                if physician == nil {Text("Add a consulting physician")}
//                if physician != nil {
//                    ForEach(0..<1){_ in
//                        PhysicianRowView(physician: self.physician)
//                    }.onDelete { (indexSet) in
//                        self.physician = nil
//                    }
//                }
//            }
//        }.cornerRadius(5)
//        .sheet(isPresented: $showPhysiciansList) {
//        PhysicianList{ md in self.physician = md }.environment(\.managedObjectContext, self.moc)}
//    }
//}
//
//struct PhysicianSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhysicianSectionView()
//    }
//}
