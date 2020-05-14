//
//  PatientRow.swift
//  karlaSUI
//
//  Created by quarticAIMBP2018 on 2020-04-20.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PatientRow: View {
    
    var patient: Patient
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {}){
                Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Rectangle())
                    .cornerRadius(3)
                    .foregroundColor(.purple)
            }
            
            VStack(alignment: .leading, spacing:2) {
                HStack{
                    Text(patient.nameLabel)
                        .font(.headline)
                        .lineLimit(1)
                    Text(patient.ageSex)
                }
                HStack{
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    Text(patient.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "bandage")
                        .foregroundColor(.gray)
                    Text("diagnosis...")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Button(action: {
                // tap to add visit
            }){
                Image(systemName: "v.square.fill")
                    .foregroundColor(Color.purple)
                    .font(.system(size: 30))
            }
            
        }
    }
}

struct PatientRow_Previews: PreviewProvider {
    static var previews: some View {
        PatientRow(patient: DummyData.dummyPatient)
    }
}
