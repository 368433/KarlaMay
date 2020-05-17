//
//  MainClinicalWorkView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct MainClinicalWorkView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UniqueTag.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "title", UniqueTagsOptions.mainClinicalList.associatedLabel )) var mainCWTag: FetchedResults<UniqueTag>
    @State private var showAddEpocForm = false
    
    private var viewTitle: String {
        return mainCWTag.first?.clinicalWork?.title ?? "No list title"
    }
    
    var body: some View {
        List{
            ForEach(mainCWTag.first?.clinicalWork?.chronologicEpisodesOfCare ?? [], id: \.self){list in
                Text("hello")
            }
        }
        .sheet(isPresented: $showAddEpocForm, content: {
            EpisodeOfCareForm().environment(\.managedObjectContext, self.moc)
        })
            .navigationBarTitle(self.viewTitle)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddEpocForm.toggle()
                }){
                    Image(systemName: "plus").padding()
            })
    }

}


struct MainClinicalWorkView_Previews: PreviewProvider {
    static var previews: some View {
        MainClinicalWorkView()
    }
}
