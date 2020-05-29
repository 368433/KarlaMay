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
    @State var status: EpocStatus = .inpatient
    var initialStatus: EpocStatus
    var parentList: ClinicalWork?
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let episode = episodeToEdit {
            self.episode = episode
            self.initialStatus = EpocStatus.forEpoc(episode)
        }
        else {
            self.episode = EpisodeOfCare(context: moc)
            self.initialStatus = .inpatient
        }
        
        if let patient = episodeToEdit?.patient {self.patient = patient}
        else {self.patient = Patient(context: moc)}
        
        self.parentList = parentList
    }
    
    var body: some View {
        ZStack{
            Color.white
            ScrollView(.vertical){
                VStack(alignment: .center){
                    HStack{
                        Button("Cancel"){self.presentationMode.wrappedValue.dismiss()}
                        Spacer()
                        Button("Done"){self.saveAndExit()}.disabled(self.patient.wrappedName.isEmpty)
                    }
                    EpisodeStatusTagPicker(status: self.$status)
                    PatientIdentificationSection(patient: self.patient)
                    consultingMDForm(episode: self.episode)
                    ModifiedDatePicker(date: self.$episode.startDate ?? Date())
                    DiagnosisSection3(episode: self.episode)
                    VisitSection(episode: self.episode)
                }.padding()
                
            }
        }
        .onAppear{
            self.episode.patient = self.patient
            self.status = self.initialStatus
        }
    }
    
    func saveAndExit(){
        self.episode.setStatus(to: self.status)
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EpisodeOfCareForm2_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm2()
    }
}
