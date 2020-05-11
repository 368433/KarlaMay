//
//  PatientFormView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

struct PatientFormView: View {
    var patient: Patient
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    @State private var postalCode = ""
    @State private var ramq = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Identification")){
                    TextField("Name", text: $name)
                    TextField("RAMQ", text: $ramq)
                    TextField("Postal Code", text: $postalCode)
                    
                }
                Section(header: Text(patient.hasNoDx() ? "No Diagnoses" : "Diagnoses")){
                    ForEach(patient.chronologicDiagnoses, id:\.self) { dx in
                        Text(dx.title ?? "No dx title")
                    }
                }
                Section(header: Text("Episodes Of Work")){
                    Text("test")
                }
            }
            .navigationBarTitle(Text("Patient"))
        }
        .onAppear(perform: fillWithPatientDetails )
    }
    private func fillWithPatientDetails(){
        self.name = patient.name ?? ""
        self.postalCode = patient.zip ?? ""
        self.ramq = patient.ramqNumber ?? ""
    }
}

struct PatientFormView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let dummyPatient = Patient(context: moc)
        dummyPatient.name = "bob"
        return PatientFormView(patient: dummyPatient)
    }
}
