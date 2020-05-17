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
    var codesGenerator = CodesGenerator(actSite:.HPB)
    @State private var actSite = ActSite.HPB
    @State private var startDate: Date = Date()
    @State private var wasBilled = false
    @State private var actDepartment = ""
    @State private var actalpha = ""
    @State private var actType = ""
    @State private var bedsideLocation = ""
    @State private var installation = ""
    
    var alpha: [String]{
        if let alph = codesGenerator.codesDict[self.actDepartment] {
            return Array(alph.keys)
        }
        return []
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
                    Picker(selection: $actSite, label: Text("Act site")) {
                        ForEach(ActSite.allCases, id:\.self) { site in
                            Text(site.rawValue).tag(site)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Act department", text: $actDepartment)
                    AutofillWordsSuggestionsView(wordList: Array(codesGenerator.codesDict.keys).sorted()) { (act) in
                        self.actDepartment = act
                    }
                }
                
                Section {
                    TextField("Act alpha", text: $actalpha)
                    AutofillWordsSuggestionsView(wordList: self.alpha.sorted()) { (act) in
                        self.actalpha = act
                    }
                }
            }
        }
    }
}

struct ClinicalVisitForm_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalVisitForm()
    }
}


/*
 DatePicker(selection: $startDate, in:...Date(), displayedComponents: .date){Text("Start Date")}
 }
 */
