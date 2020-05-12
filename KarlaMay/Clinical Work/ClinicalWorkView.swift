//
//  ClinicalWorkView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkView: View {
    
    var clinicalWork: ClinicalWork
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddEpisodeOfCareForm = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading, spacing: 0){
                ClinicalWorkBanderoleView(clinicalWork: self.clinicalWork)
                List{
                    ForEach(self.clinicalWork.chronologicEpisodesOfCare) { eoc in
                        NavigationLink(destination: Text("test")) {
                            EpisodeOfCareRowView(episodeOfCare: eoc)
                        }
                    }.onDelete(perform: deleteRow)
                }
                .navigationBarTitle(Text("Work List"))
                .navigationBarItems(
                    leading: Button(action:{self.showAddEpisodeOfCareForm.toggle()}){
                    Image(systemName: "plus").font(.title)
                },
                    trailing: Button("Done"){
                        do{
                            try self.moc.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                })
                    .alert(isPresented: $showDeleteAlert) { () -> Alert in
                        Alert(title: Text("Deleting row"), message: Text("This will permanently remove this element from the record"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                            //remove from database
                        }))
                }
            }
        }
    }
    private func deleteRow(at index: IndexSet) {
        self.showDeleteAlert.toggle()
    }
}

struct ClinicalWorkView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkView(clinicalWork: DummyData.dummyClinicalWork)
    }
}
