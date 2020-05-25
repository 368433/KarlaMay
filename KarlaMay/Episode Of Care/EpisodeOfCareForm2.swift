//
//  EpisodeOfCareForm2.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-24.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpisodeOfCareForm2: View {
    
    @State private var name: String = ""
    
    @ObservedObject var episode: EpisodeOfCare
    @ObservedObject var patient: Patient
    @ObservedObject var consultingPhysician: Physician
    var diagnoses: [Diagnosis] = []
    var visits: [ClinicalVisit] = []
    var parentList: ClinicalWork?
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.episode = episodeToEdit != nil ? episodeToEdit! : EpisodeOfCare(context: moc)
        self.patient = episodeToEdit?.patient != nil ? episodeToEdit!.patient! : Patient(context: moc)
        if let physician = episodeToEdit?.consultingPhysician { self.consultingPhysician = physician}
        else {self.consultingPhysician = Physician(context: moc)}
        if let diagnoses = episodeToEdit?.currentDiagnoses as? Set<Diagnosis> {self.diagnoses = Array(diagnoses)}
        if let visits = episodeToEdit?.clinicalVisits as? Set<ClinicalVisit> {self.visits = Array(visits)}
        self.parentList = parentList
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Identification")){
                    TextField("Name", text: $patient.name ?? "")
                    NavigationLink(destination: Text("testing")){
                        Button(action:{}){
                            HStack{
                                Text("Physician")
                                Spacer()
                                Text("Alphonso")
                            }
                        }.padding(.trailing)
                        
                    }
                }
            }
        }
    }
}

struct EpisodeOfCareForm2_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm2()
    }
}
