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
    @ObservedObject var dxResult = ICDresult()
    var diagnoses: [Diagnosis] = []
    var visits: [ClinicalVisit] = []
    var parentList: ClinicalWork?
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let episode = episodeToEdit { self.episode = episode }
        else { self.episode = EpisodeOfCare(context: moc)}
        
        if let patient = episodeToEdit?.patient {self.patient = patient}
        else {self.patient = Patient(context: moc)}
        
        self.parentList = parentList
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Form{
                    PatientIdentificationSection(patient: self.patient)
                    consultingMDForm(episode: episode)
                    DatePicker(selection: self.$episode.startDate ?? Date(), in:...Date(), displayedComponents: .date){Text("Start Date")}
                    DiagnosisSection2(episode: self.episode)
                }
            }
        .navigationBarTitle("Cue Card")
            .navigationBarItems(
                leading: Button("Cancel"){
                    print(self.episode.currentDiagnoses?.count)
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing:Button("Done"){
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }.disabled(self.patient.wrappedName.isEmpty))
        }
        .onAppear {self.episode.patient = self.patient}
    }
}

struct EpisodeOfCareForm2_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm2()
    }
}
