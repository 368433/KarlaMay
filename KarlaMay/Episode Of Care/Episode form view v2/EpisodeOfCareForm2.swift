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
    var initialStatus: EpocStatus = .inpatient
    var parentList: ClinicalWork?
    @State var diagnosticList = [Diagnosis]()
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let episode = episodeToEdit {
            self.episode = episode
            self.initialStatus = EpocStatus.forEpoc(episode)
        }
        else {self.episode = EpisodeOfCare(context: moc)}
        
        if let patient = episodeToEdit?.patient {self.patient = patient}
        else {self.patient = Patient(context: moc)}
        
        self.parentList = parentList
    }
    
    var body: some View {
        ZStack{
            Color.lightSmoke
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    HStack{
                        Button("Cancel"){self.presentationMode.wrappedValue.dismiss()}
                        Spacer()
                        Button("Done"){self.saveAndExit()}.disabled(self.patient.wrappedName.isEmpty)
                    }
                    EpisodeStatusTagPicker(status: self.$status).padding()
                    
                    PatientIdentificationSection(patient: self.patient)
                    
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(Color.blue)
                            //RoundedRectangle(cornerRadius: 5).stroke()
                            VStack(alignment: .leading){
                                Text("Consulted by").fontWeight(.heavy)
                                Text("physician name")
                            }.padding()
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.systemGray6))
                            VStack{
                                Text("Start date").fontWeight(.heavy).foregroundColor(.gray)
                                Text("physician name")
                            }.padding()
                        }
                        //consultingMDForm(episode: self.episode)
                        //ModifiedDatePicker(date: self.$episode.startDate ?? Date())
                    }.padding().foregroundColor(.white)
                    
                    DiagnosisSection3(diagnosticList: $diagnosticList).padding()
                    VisitSection(episode: self.episode)
                }.padding()
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
        .onAppear{
            self.episode.patient = self.patient
            self.status = self.initialStatus
            if let dxList = self.episode.currentDiagnoses as? Set<Diagnosis> {
                self.diagnosticList = Array(dxList).sorted()
            }
        }
    }
    
    func saveAndExit(){
        self.episode.currentDiagnoses?.addingObjects(from: diagnosticList)
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
