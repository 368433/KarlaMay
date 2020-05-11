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
//                HStack{
//                    Spacer()
//                    Button(action: {}){
//                        Image(systemName: "doc.text.viewfinder").font(.title)
//                    }
//                }
                Section(header: HStack {
                    Text("Identification")
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "doc.text.viewfinder").font(.title)
                    }
                }){
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
                Section(header:
                    HStack {
                        Text(patient.hasNoEOC() ? "No Episodes Of Care" : "Episodes Of Care")
                        Spacer()
                        Button(action: {}){Text("Add")}
                }){
                    ForEach(patient.chronologicEpisodesOfCare, id:\.self) { eoc in
                        Text( eoc.episodeLabel)
                    }
                }
                Section(header:
                    HStack {
                        Text(patient.hasNoVisits() ? "No Visits" : "Visits")
                        Spacer()
                        Button(action: {}){Text("Add")}
                }){
                    ForEach(patient.chronologicClinicalVisits, id:\.self) { visit in
                        Text(visit.clinicalVisitLabel)
                    }
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

#if DEBUG
struct PatientFormView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let dummyPatient = Patient(context: moc)
        let visit = ClinicalVisit(context: moc)
        visit.startDate = Date()
        visit.actType = "VP 9160"
        dummyPatient.name = "bob"
        dummyPatient.addToClinicalVisits(visit)
        return
            Group{
                PatientFormView(patient: dummyPatient).environment(\.colorScheme, .dark)
                PatientFormView(patient: dummyPatient).environment(\.colorScheme, .light)
        }
    }
}
#endif
