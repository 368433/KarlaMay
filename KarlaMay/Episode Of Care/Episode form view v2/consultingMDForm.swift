//
//  consultingMDForm.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-25.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct consultingMDForm: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var episode : EpisodeOfCare
    @State var showMdList = false
    
    init(episode: EpisodeOfCare){
        self.episode = episode
    }
    
    var physicianLicense: some View {
        guard let md = self.episode.consultingPhysician else { return Text("n/a").foregroundColor(.secondary)}
        guard let license = md.license else { return Text("license n/a").foregroundColor(.secondary)}
        return Text(license).foregroundColor(.secondary)
    }
    var nameLabel: some View {
        guard let md = self.episode.consultingPhysician else {
            return Text("None assigned").foregroundColor(.secondary)}
        guard let name = md.name else { return Text("Missing name")}
        return Text(name)
    }
    
    var body: some View {
        VStack{
            if self.episode.consultingPhysician != nil{
                Text("Consulted by").fontWeight(.bold)
                nameLabel
                physicianLicense
            }else{
                HStack{
                    Text("Select consulting physician").fontWeight(.bold)
                    Spacer()
                }
                
            }
        }.padding().foregroundColor(.white).background(Color.blue).cornerRadius(5)
            .onTapGesture {self.showMdList.toggle()}
        .sheet(isPresented: $showMdList) {
            PhysicianList { (md) in self.episode.consultingPhysician = md }.environment(\.managedObjectContext, self.moc)
        }
    }
}

struct consultingMDForm_Previews: PreviewProvider {
    static var previews: some View {
        consultingMDForm(episode: DummyData.dummyEpisodeOfCare)
    }
}
