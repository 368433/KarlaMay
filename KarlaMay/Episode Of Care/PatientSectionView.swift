//
//  PatientSectionView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PatientSectionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var showFullIdentity = false
    @ObservedObject var patient: Patient
    
    var body: some View {
        HStack {
            Color.purple.frame(width:10)
            VStack {
                Section(header: HStack {
                    Text("Identification")
                    Button(showFullIdentity ? "Minimize":"Show full") {self.showFullIdentity.toggle()}
                    Spacer()
                    Button(action: {}){ Image(systemName: "doc.text.viewfinder").font(.title) }})
                {
                    TextField("Name", text: self.$patient.name ?? "")
                    if showFullIdentity{
                        TextField("RAMQ", text: self.$patient.ramqNumber ?? "")
                        TextField("Postal Code", text: self.$patient.postalCode ?? "")
                    }
                }
            }
        }.cornerRadius(5)
    }
}

struct PatientSectionView_Previews: PreviewProvider {
    static var previews: some View {
        PatientSectionView(patient: DummyData.dummyPatient)
    }
}
