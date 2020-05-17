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
    @State private var name = ""
    @State private var postalCode = ""
    @State private var ramqNumber = ""
    @State private var startDate: Date = Date()
    @State private var epocStatus: EpocStatus = .inpatient
    @State private var visits: [ClinicalVisit] = []
    
    @State private var showFullIdentity = false
    @State private var showICDSearch = false
    @State private var showAddClinicalVisitForm = false
    @State private var hideDiagnosesList = false
    
    var epoc: EpisodeOfCare?
    
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
                        TextField("RAMQ", text: $ramqNumber)
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
        .onAppear(perform: populateFields )
    }
    
    private func deleteDiagnosis(at indexSet: IndexSet ){
        for index in indexSet {
            dxResult.results.remove(at: index)
        }
    }
    
    private func populateFields(){
        if let epoc = epoc {
            self.startDate = epoc.startDate ?? Date()
            self.epocStatus = EpocStatus.forEpoc(epoc)
            self.visits = epoc.sortedVisits
            self.dxResult.results = (epoc.diagnosis != nil) ? [epoc.diagnosis!]:[]
            if let patient = epoc.patient {
                self.name = patient.name ?? ""
                self.postalCode = patient.postalCode ?? ""
                self.ramqNumber = patient.ramqNumber ?? ""
            }
        }
    }
    private func dismissView(){
        self.presentationMode.wrappedValue.dismiss()
    }
    private func saveValues(){
        let ptValues: [String: Any] = ["name":self.name, "postalCode":self.postalCode, "ramqNumber":self.ramqNumber]
        
        let epocToSave = (epoc != nil) ? epoc: EpisodeOfCare(context: moc)
        epocToSave?.startDate = self.startDate
        epocToSave?.setStatus(to: epocStatus)
        epocToSave?.addToClinicalVisits(NSSet(array: visits))
        epocToSave?.diagnosis = self.dxResult.results.first ?? nil
        
        let ptToSave = (epocToSave?.patient != nil) ? epocToSave?.patient : Patient(context: moc)
        ptToSave?.setValuesForKeys(ptValues)
        
        epocToSave?.patient = ptToSave
        
        try? self.moc.save()
        
//        let newEpoc = EpisodeOfCare(context: moc)
//        newEpoc.startDate = self.startDate
//        newEpoc.setStatus(to: epocStatus)
//        newEpoc.addToClinicalVisits(NSSet(array: visits))
//        newEpoc.diagnosis = self.dxResult.results.first ?? nil
//        //pt
//        let newPt = Patient(context: moc)
//        newPt.name = self.name
//        newPt.ramqNumber = self.ramqNumber
//        newPt.postalCode = self.postalCode
//        newEpoc.patient = newPt
//
//        if let epoc = epoc {
//            epoc.startDate = self.startDate
//            epoc.setStatus(to: epocStatus)
//            epoc.addToClinicalVisits(NSSet(array: visits))
//            epoc.diagnosis = self.dxResult.results.first ?? nil
//            if let patient = epoc.patient {
//                patient.name = self.name
//                patient.ramqNumber = self.ramqNumber
//                newEpoc.patient = patient
//            } else {
//                let newPt = Patient(context: moc)
//                newPt.name = self.name
//                newPt.ramqNumber = self.ramqNumber
//                newPt.postalCode = self.postalCode
//                epoc.patient = newPt
//            }
//        }
        
        
    }
    func setEpocValues(){}
    func setPatientValues(for: Patient){
        
    }
}


struct EpisodeOfCareForm_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm()
    }
}
