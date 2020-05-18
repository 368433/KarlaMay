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
    @ObservedObject var visitz = VisitsResults()
    
    @State private var physician: Physician?
    @State private var name = ""
    @State private var postalCode = ""
    @State private var ramqNumber = ""
    @State private var startDate: Date = Date()
    @State private var epocStatus: EpocStatus = .inpatient
    
    @State private var showFullIdentity = false
    @State private var showICDSearch = false
    @State private var showAddClinicalVisitForm = false
    @State private var showPhysiciansList = false
    @State private var showStartDate = false
    
    var epoc: EpisodeOfCare?
    var parentList: ClinicalWork?
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
            ScrollView(.vertical){
                
                HStack {
                    Color.purple.frame(width:10)
                    VStack {
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
                    }
                }.cornerRadius(5)
                    
                    /// EPISODE OF CARE
                HStack {
                    Color.green.frame(width:8)
                    VStack {
                        Section(header: HStack{
                                Text("Episodes Of Care")
                                Button(self.showStartDate ? "Hide date":"Show start date") { self.showStartDate.toggle()}
                                Spacer()
                                })
                            {
                                Picker(selection: $epocStatus, label: Text("Status")){
                                    ForEach(EpocStatus.allCases, id: \.self){ status in
                                        Text(status.rawValue).tag(status)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                                if self.showStartDate {
                                    Form{
                                    DatePicker(selection: $startDate, in:...Date(), displayedComponents: .date){Text("Start Date")}
                                    }
                                }
                        }
                    }
                }.cornerRadius(5)
                    
                    /// PHYSICIAN
                    HStack {
                        Color.red.frame(width:10)
                        VStack(alignment: .leading){
                            HStack{
                                Text("Consulting Physician")
                                Spacer()
                                Button(action: {self.showPhysiciansList.toggle()}){AddIcon()}
                            }
                            if physician == nil {Text("Add a consulting physician")}
                            if physician != nil {
                                ForEach(0..<1){_ in
                                    PhysicianRowView(physician: self.physician!)
                                }.onDelete { (indexSet) in
                                    self.physician = nil
                                }
                            }
                        }
                }.cornerRadius(5)
                    
                DiagnosisSectionView(dxResult: dxResult)
                VisitSectionView(visits: visitz)
                }
                .onAppear(perform: populateFields )
                .navigationBarTitle(Text("Patient"))
                .navigationBarItems(leading: Button("Cancel"){self.dismissView()},
                                    trailing: Button("Done"){
                            self.saveValues()
                            self.dismissView()}.disabled(self.name == "" || self.dxResult.results.isEmpty))
                    .sheet(isPresented: $showPhysiciansList) {
                        PhysicianList{ md in self.physician = md }.environment(\.managedObjectContext, self.moc)}
            }.padding([.leading, .trailing])
        }
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
            self.visitz.results = epoc.sortedVisits
            self.dxResult.results = (epoc.diagnosis != nil) ? [epoc.diagnosis!]:[]
            if let secondary = epoc.secondaryDiagnoses as? Set<Diagnosis> {
                self.dxResult.results.append(contentsOf: secondary)
            }
            self.physician = epoc.consultingPhysician
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
        guard let epocToSave = (epoc != nil) ? epoc: EpisodeOfCare(context: moc) else {print("Error creating epoc to save in epoc form view"); return }
        epocToSave.startDate = self.startDate
        epocToSave.setStatus(to: epocStatus)
        epocToSave.clinicalVisits = NSSet(array: visitz.results)
        epocToSave.diagnosis = self.dxResult.results.first
        epocToSave.secondaryDiagnoses = NSSet(array:self.dxResult.results)
        epocToSave.consultingPhysician = physician
        
        if let ptToSave = (epocToSave.patient != nil) ? epocToSave.patient : Patient(context: moc) {
            let ptValues: [String: Any] = ["name":self.name, "postalCode":self.postalCode, "ramqNumber":self.ramqNumber]
            ptToSave.setValuesForKeys(ptValues)
            ptToSave.diagnoses = NSSet(array: dxResult.results)
            epocToSave.patient = ptToSave
        }
        
        epocToSave.clinicalWork = parentList
        try? self.moc.save()
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
