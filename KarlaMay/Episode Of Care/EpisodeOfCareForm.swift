//
//  EpisodeOfCareForm.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-14.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpisodeOfCareForm: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presenting
    
    @State private var diagnosis: String = ""
    @State var parentList: ClinicalWork?
    @State var patient: Patient?
    @State private var patientName: String = ""
    @State private var startDate: Date = Date()
    @State private var numberOfDx: Int = 1
    @State private var epocStatus: EpocStatus = .inpatient
    @State private var nbOfDx = 1
    @State private var diagnoses: [Diagnosis] = []
    @State private var newDxName = ""

    @State private var showSearch = false
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Patient")){
                    HStack{
                        Text(patient?.name ?? "None")
                        Spacer()
                        Button(action: {self.showSearch.toggle()}){Image(systemName: "plus.rectangle.fill").font(.system(size: 28))}
                    }
                }
                Section(header: Text("Liste")){
                    HStack{
                        Text(parentList?.title ?? "List has no title")
                        Spacer()
                        Button(action: {self.showSearch.toggle()}){Image(systemName: "plus.rectangle.fill").font(.system(size: 28))}
                    }
                }
                Section(header: Text("Status")){
                    Picker(selection: $epocStatus, label: Text("Status")){
                        ForEach(EpocStatus.allCases, id: \.self){ status in
                            Text(status.rawValue).tag(status)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                DatePicker(selection: $startDate, in:...Date(), displayedComponents: .date){Text("Start Date")}
                
                Section(header: Text("Diagnosis")) {
                    HStack{
                        TextField("Enter diagnosis", text: $newDxName)
                        Button("Add"){
                            let newDx = Diagnosis(context: self.moc)
                            newDx.title = self.newDxName
                            newDx.startDate = self.startDate
                            self.newDxName = ""
                        }
                    }
                }
            }
            .navigationBarTitle("Work card", displayMode: .automatic)
            .navigationBarItems(
                leading: Button("Cancel") {self.presenting.wrappedValue.dismiss()},
                trailing: Button("Done") {self.saveAndDismiss()}.disabled(self.patientName == "" && self.diagnosis == ""))
                .sheet(isPresented: $showSearch){SearchView().environment(\.managedObjectContext, self.moc)}
        }
    }
    
    private func removeDiagnosis(at offSets: IndexSet){
        if !self.diagnoses.isEmpty {
            for index in offSets {
                self.diagnoses.remove(at: index)
            }
        }
    }
    
    private func saveAndDismiss(){
        self.assignValues()
        try? self.moc.save()
        self.presenting.wrappedValue.dismiss()
    }
    
    private func assignValues(){
        let send = EpisodeOfCare(context: moc)
        let newDx = Diagnosis(context: moc)
        newDx.title = self.diagnosis
        send.diagnosis = newDx
        send.clinicalWork = self.parentList
        send.startDate = self.startDate
        
        if let _ = patient {
            self.patient!.name = self.patientName
            send.patient = patient
        } else {
            //no patient was included, need to create a new one
            let newPt = Patient(context: moc)
            newPt.name = self.patientName
            send.patient = newPt
        }
        try? self.moc.save()
    }
}

struct EpisodeOfCareForm_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm()
    }
}
