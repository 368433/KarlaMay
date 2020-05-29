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
        ZStack{
            Color.white
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Text("Patient").fontWeight(.heavy)
                    Spacer()
                    Button("View"){}.font(.footnote)
                }
                HStack(alignment:.top){
                    HStack(alignment:.center){
                        LinedTextField(text: self.$patient
                            .wrappedName, title: "Name", isRequired: true)
                        LinedTextField(text: self.$patient.ramqNumber ?? "", title: "#Chart", isRequired: false)
                    }
                    Spacer()
                    Text("34 yo").font(.largeTitle)
                }
            }.padding()
        }.clipped().cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

struct PatientIdentificationSection_Previews: PreviewProvider {
    static var previews: some View {
        PatientIdentificationSection(patient: DummyData.dummyPatient)
    }
}
