//
//  ClinicalWorkFormView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkFormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var startDate = Date()
    @State private var isActive = true
    @State private var isMainList = false
    @State private var comments = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text(""),
                        footer: AutofillWordsSuggestionsView(action:{word in self.title += word + " "}))
                {
                    TextField("Title", text: $title, onEditingChanged: {_ in print("change")})
                }
                Section(){
                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Text("Start date")
                    }
                }
                Section{
                    Toggle(isOn: $isActive, label: {Text("Active list: ")})
                    Toggle(isOn: $isMainList, label: {Text("Main list:  ")})
                }
                Section(header: Text("Comments")) {
                    TextField("Description and comments", text: $comments)
                }
            }
                
            .navigationBarTitle("Create Work List")
            .navigationBarItems(leading: Button("Cancel"){
                self.dismissForm()
                }, trailing: Button("Done"){
                    self.saveForm()
                    self.dismissForm()
                }.disabled(formIsDisabled())
            )
        }
    }
    private func formIsDisabled() ->Bool {
        return self.title.isEmpty
    }
    private func saveForm() {
        let newCW = ClinicalWork(context: self.moc)
        newCW.startDate = self.startDate
        newCW.title = self.title
        newCW.isActive = self.isActive
        newCW.isMainList = self.isMainList
        newCW.comments = self.comments
        try? self.moc.save()
    }
    private func dismissForm(){
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ClinicalWorkFormView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkFormView()
    }
}
