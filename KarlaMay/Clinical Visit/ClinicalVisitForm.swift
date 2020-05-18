//
//  ClinicalVisitForm.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-17.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalVisitForm: View {
    
    var visit: ClinicalVisit?
    var completion: (_ visit: ClinicalVisit) -> Void
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var startDate: Date = Date()
    @State private var actType = ""    
    
    init(visit: ClinicalVisit? = nil, completion: @escaping (_ visit: ClinicalVisit)->Void){
        self.visit = visit
        self.completion = completion
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Text("Start date")
                    }
                }
                Section{
                    TextField("Act type", text: $actType)
                    AutofillWordsSuggestionsView(wordList: ["VP", "C", "VC", "OPAT"]) { (act) in
                        self.actType = act
                    }
                }
            }
            .navigationBarItems(
                leading: Button("Cancel"){
                    self.presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done"){
                    self.saveData()
                    self.presentationMode.wrappedValue.dismiss()
                }.disabled(self.actType.isEmpty))
        }
    }
    private func saveData(){
        guard let visitToSave = ((self.visit != nil) ? self.visit:ClinicalVisit(context: moc)) else {return}
        visitToSave.startDate = self.startDate
        visitToSave.actType = self.actType
        DispatchQueue.main.async {
            self.completion(visitToSave)
        }
    }
}

struct ClinicalVisitForm_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalVisitForm(completion:{_ in})
    }
}
