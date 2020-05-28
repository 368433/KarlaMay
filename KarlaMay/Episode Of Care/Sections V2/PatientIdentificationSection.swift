//
//  PatientIdentificationSection.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-26.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PatientIdentificationSection: View {
    
    @ObservedObject var patient: Patient
    
    var body: some View {
        Section(header: HStack {
            Text("Patient identification")
            Spacer()
            Button(action: {}){Image(systemName: "magnifyingglass").font(.headline)}.padding(.trailing)
            Button(action: {}){Image(systemName: "doc.text.viewfinder").font(.title) }
        }){
            VStack(alignment: .leading, spacing: 0){
                if !self.patient.wrappedName.isEmpty {
                    Text("Name".capitalized).font(.footnote).foregroundColor(.blue)
                }
                HStack{
                    TextField("Name", text: self.$patient.wrappedName)
                    Spacer()
                    if self.patient.wrappedName.isEmpty {
                        Text("required".capitalized).font(.footnote).foregroundColor(.red)
                    }
                }
            }.animation(.easeInOut(duration: 0.3))
            TextField("RAMQ", text: self.$patient.ramqNumber ?? "")
            TextField("Postal Code", text: self.$patient.postalCode ?? "")
        }
    }
}

struct PatientIdentificationSection_Previews: PreviewProvider {
    static var previews: some View {
        PatientIdentificationSection(patient: DummyData.dummyPatient)
    }
}
