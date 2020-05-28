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
    
    var physicianLicense: String {
        guard let md = self.episode.consultingPhysician else { return ""}
        guard let license = md.license else { return "Missing license"}
        return license
    }
    var nameLabel: some View {
        guard let md = self.episode.consultingPhysician else {
            return Text("None assigned").foregroundColor(.secondary)}
        guard let name = md.name else { return Text("Missing name")}
        return Text(name)
    }
    
    var body: some View {
        NavigationLink(destination: PhysicianList(completion: { (md) in
            self.episode.consultingPhysician = md
        })){
            HStack{
                Text("Doctor:")
                Spacer()
                VStack(alignment:.trailing) {
                    nameLabel
                    if self.episode.consultingPhysician != nil {
                        Text(physicianLicense).foregroundColor(.secondary)
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
