//
//  PatientIdentificationSection.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-26.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PatientIdentificationSection: View {
    
    @ObservedObject var episode : EpisodeOfCare
    
    init(episode: EpisodeOfCare){
        self.episode = episode
    }
    
    var body: some View {
         Section(header: Text("Consulting Physician")){
            Text("test")
        }
    }
}

struct PatientIdentificationSection_Previews: PreviewProvider {
    static var previews: some View {
        PatientIdentificationSection(episode: DummyData.dummyEpisodeOfCare)
    }
}
