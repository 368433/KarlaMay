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
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dxResult = ICDresult()
    
    @State private var md: Physician?
    @State var patient: Patient?
    @State private var name = ""
    @State private var postalCode = ""
    @State private var ramq = ""
    @State private var startDate: Date = Date()
    @State private var epocStatus: EpocStatus = .inpatient
    @State private var visits: [ClinicalVisit] = []
    
    @State private var showFullIdentity = false
    @State private var showICDSearch = false
    @State private var showAddClinicalVisitForm = false
    @State private var hideDiagnosesList = false
    
    var parentList: ClinicalWork?
    
    private var addIcon: some View {
        Image(systemName: "plus.rectangle.fill").font(.system(size: 24))
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: HStack {
                    Text("Identification")
                    Button(showFullIdentity ? "Minimize":"Show full") {self.showFullIdentity.toggle()}
                    Spacer()
                    Button(action: {}){ Image(systemName: "doc.text.viewfinder").font(.title) }})
                {
                    TextField("Name", text: $name)
                    if showFullIdentity{
                        TextField("RAMQ", text: $ramq)
                        TextField("Postal Code", text: $postalCode)
                    }
                }
                
                Section(header: Text("Episodes Of Care"))
                {
                    Picker(selection: $epocStatus, label: Text("Status")){
                        ForEach(EpocStatus.allCases, id: \.self){ status in
                            Text(status.rawValue).tag(status)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    DatePicker(selection: $startDate, in:...Date(), displayedComponents: .date){Text("Start Date")}
                }
                
                Section(header: VStack(alignment: .leading, spacing:0){
                    HStack{ Text("Consulting Physician");Spacer();Button(action: {}){self.addIcon}}
                    if md == nil {
                        Text("Add a consulting physician")
                    }}){
                        if md != nil {
                            Text(md?.name ?? "")
                        }
                }
                
                Section(header: VStack(alignment: .leading, spacing:0){
                    HStack { Text("Diagnosis");Spacer();Button(action: {self.showICDSearch.toggle()}){self.addIcon}}
                    if dxResult.results.isEmpty{
                        Text("No diagnosis currently selected").foregroundColor(.secondary).font(.footnote)
                    }})
                {
                    ForEach(self.dxResult.results, id: \.self){ dx in
                        DiagnosisRowView(diagnosis: dx)
                    }.onDelete(perform: deleteDiagnosis)
                }
                
                Section(header: VStack(alignment: .leading, spacing:0){
                    HStack {Text("Visits");Spacer();Button(action: {self.showAddClinicalVisitForm.toggle()}){self.addIcon}}
                    if visits.isEmpty {
                        Text("Currently no visits registered")
                    }}){
                        ForEach(visits, id: \.self){ visit in
                            Text(visit.actType ?? "No act type")
                        }
                }
            }
            .sheet(isPresented: $showICDSearch){WHOICDSearchView(returnedSearchResults: self.dxResult).environment(\.managedObjectContext, self.moc)}
            .navigationBarTitle(Text("Patient"))
            .navigationBarItems(
                leading: Button("Cancel"){
                    self.dismissView()
                }, trailing: Button("Done"){
                    self.saveValues()
                    self.dismissView()
                }.disabled(self.name == "" || self.dxResult.results.isEmpty))
        }
        .onAppear(perform: fillWithPatientDetails )
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet ){
        for index in indexSet {
            dxResult.results.remove(at: index)
        }
    }
    
    private func fillWithPatientDetails(){
        if let patient = patient {
            self.name = patient.name ?? ""
            self.postalCode = patient.zip ?? ""
            self.ramq = patient.ramqNumber ?? ""
        }
    }
    private func dismissView(){
        self.presentationMode.wrappedValue.dismiss()
    }
    private func saveValues(){
        let newEpoc = EpisodeOfCare(context: moc)
        newEpoc.diagnosis = self.dxResult.results.first ?? nil
        newEpoc.clinicalWork = self.parentList
        newEpoc.startDate = self.startDate
        newEpoc.addToClinicalVisits(NSSet(array: visits))
        newEpoc.isActive = self.epocStatus != EpocStatus.archived
        newEpoc.isInpatient = self.epocStatus == EpocStatus.inpatient
        newEpoc.isMine = self.epocStatus != EpocStatus.transferred
        
        if let patient = patient {
            patient.name = self.name
            patient.ramqNumber = self.ramq
            newEpoc.patient = patient
        } else {
            let patient = Patient(context: moc)
            patient.name = self.name
            patient.ramqNumber = self.ramq
            newEpoc.patient = patient
        }
        
        try? self.moc.save()
    }
}


struct EpisodeOfCareForm_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm()
    }
}
