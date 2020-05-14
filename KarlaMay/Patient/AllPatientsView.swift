//
//  AllPatientsView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-14.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct AllPatientsView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var showPatientForm = false

    
    var body: some View {
        List{
            DynamicFilteredList(sorting: [NSSortDescriptor(keyPath: \Patient.name, ascending: true)], predicate: nil) { (patient: Patient) in
                Text(patient.name ?? "NO name")
            }
        }
        .navigationBarItems(trailing: Button("Add"){self.showPatientForm.toggle()})
        .sheet(isPresented: $showPatientForm) {
            PatientFormView(patient: nil).environment(\.managedObjectContext, self.moc)
        }
    }
}

struct AllPatientsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPatientsView()
    }
}
