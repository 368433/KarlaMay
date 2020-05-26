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
    //    @ObservedObject var patient: Patient
    var diagnoses: [Diagnosis] = []
    var visits: [ClinicalVisit] = []
    var parentList: ClinicalWork?
    
    init(episodeToEdit: EpisodeOfCare? = nil, parentList: ClinicalWork? = nil){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.episode = episodeToEdit != nil ? episodeToEdit! : EpisodeOfCare(context: moc)
        self.parentList = parentList
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Form{
                    consultingMDForm(episode: episode)
                }
            }
        .navigationBarTitle("test")
        }
    }
}

struct EpisodeOfCareForm2_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeOfCareForm2()
    }
}
