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
    @Environment(\.presentationMode) var presentationMode
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
                Section(header:
                    HStack {
                        Text(patient.hasNoDx() ? "No Diagnoses" : "Diagnoses")
                        Spacer()
                        Button(action: {}){Text("Add")}
                }){
                    ForEach(patient.chronologicDiagnoses, id:\.self) { dx in
                        Text(dx.title ?? "No dx title")
                    }
                }
                Section(header: Text("Episodes Of Work")){
                    Text("test")
                }
                
                Section(header: Text("Clinical Visits")){
                    Text("test")
                }
                
            }
            .navigationBarTitle(Text("Patient"))
        .navigationBarItems(
            leading: Button("Cancel"){
                self.dismissView()
            }, trailing: Button("Done"){
                self.saveValues()
                self.dismissView()
        })
        }
        .onAppear(perform: fillWithPatientDetails )
    }
    private func fillWithPatientDetails(){
        self.name = patient.name ?? ""
        self.postalCode = patient.zip ?? ""
        self.ramq = patient.ramqNumber ?? ""
    }
    private func dismissView(){
        self.presentationMode.wrappedValue.dismiss()
    }
    private func saveValues(){
        
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
