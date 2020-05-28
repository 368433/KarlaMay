//
//  EpisodeOfCareForm2.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-24.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpisodeOfCareForm2: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var episode: EpisodeOfCare
    @ObservedObject var patient: Patient
//    @ObservedObject var dxResult = ICDresult()
    var parentList: ClinicalWork?
    
    var viewTitle: String = ""
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let episode = episodeToEdit { self.episode = episode }
        else { self.episode = EpisodeOfCare(context: moc)}
        
        if let patient = episodeToEdit?.patient {self.patient = patient}
        else {self.patient = Patient(context: moc)}
        
//        if let diagnosticList = episodeToEdit?.currentDiagnoses as? Set<Diagnosis> {
//            self.dxResult.results = Array(diagnosticList).sorted()
//        }
        self.parentList = parentList
        self.viewTitle = episodeToEdit == nil ? "New episode":"Editing episode"
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Form{
                    PatientIdentificationSection(patient: self.patient)
                    consultingMDForm(episode: episode)
                    DatePicker(selection: self.$episode.startDate ?? Date(), in:...Date(), displayedComponents: .date){Text("Start Date")}
                    //DiagnosisSection2(diagnosticList: dxResult)
                    DiagnosisSection3(episode: self.episode)
                    
                    Section(header: Text("Visits")){
                        VisitSection(episode: self.episode)
                    }
                }
            }
            .navigationBarTitle(self.viewTitle)
            .navigationBarItems(
                leading: Button("Cancel"){
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing:Button("Done"){
                    self.saveAndExit()
                }.disabled(self.patient.wrappedName.isEmpty))
        }
        .onAppear(perform: self.setup)
    }
    private func setup(){
        self.episode.patient = self.patient
    }

    func saveAndExit(){
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EpisodeOfCareForm2_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm2()
    }
}
