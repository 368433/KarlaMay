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
    
    @State private var showAddDiagnosisForm = false
    @State private var showAddEpisodeOfCareForm = false
    @State private var showAddClinicalVisitForm = false
    
    var body: some View {
//        NavigationView{
            Form{
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
                        Button(action: {self.showAddDiagnosisForm.toggle()}){Text("Add")}
                }){
                    ForEach(patient.chronologicDiagnoses, id:\.self) { dx in
                        DiagnosisRowView(diagnosis: dx)
                    }
                }
                Section(header:
                    HStack {
                        Text(patient.hasNoEOC() ? "No Episodes Of Care" : "Episodes Of Care")
                        Spacer()
                        Button(action: {self.showAddEpisodeOfCareForm.toggle()}){Text("Add")}
                }){
                    ForEach(patient.chronologicEpisodesOfCare, id:\.self) { eoc in
                        EpisodeOfCareRowView(episodeOfCare: eoc)
                    }
                }
                Section(header:
                    HStack {
                        Text(patient.hasNoVisits() ? "No Visits" : "Visits")
                        Spacer()
                        Button(action: {self.showAddClinicalVisitForm.toggle()}){Text("Add")}
                }){
                    ForEach(patient.chronologicClinicalVisits, id:\.self) { visit in
                        ClinicalVisitRowView(clinicalVisit: visit)
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
//        }
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
    static var previews: some View {
        Group{
            PatientFormView(patient: DummyData.dummyPatient).environment(\.colorScheme, .dark)
            PatientFormView(patient: DummyData.dummyPatient).environment(\.colorScheme, .light)
        }
    }
}
#endif
