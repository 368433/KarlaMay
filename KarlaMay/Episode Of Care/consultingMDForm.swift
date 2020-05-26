//
//  consultingMDForm.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-25.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct consultingMDForm: View {
    
    @ObservedObject var episode : EpisodeOfCare
    
    init(episode: EpisodeOfCare){
        self.episode = episode
    }
    
    var physicianName: String {
        guard let md = self.episode.consultingPhysician else { return "None assigned"}
        guard let name = md.name else { return "Missing name"}
        return name
    }
    
    var physicianLicense: String {
        guard let md = self.episode.consultingPhysician else { return ""}
        guard let license = md.license else { return "Missing license"}
        return license
    }
    
    var body: some View {
        Section(header: Text("Consulting Physician")){
            NavigationLink(destination: PhysicianList(completion: { (md) in
                self.episode.consultingPhysician = md
            })){
                HStack{
                    Text("Physician")
                    Spacer()
                    VStack(alignment:.trailing) {
                        Text(physicianName)
                        if self.episode.consultingPhysician != nil {
                            Text(physicianLicense).foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct consultingMDForm_Previews: PreviewProvider {
    static var previews: some View {
        consultingMDForm(episode: DummyData.dummyEpisodeOfCare)
    }
}
