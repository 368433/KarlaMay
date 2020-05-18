//
//  PhysicianForm.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-17.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct PhysicianForm: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var license = ""
    @State private var name = ""
    
    var physician: Physician?
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Physician's name", text: $name)
                    TextField("Physician's license", text: $license)
                }
            }
        .navigationBarTitle("Physician")
            .navigationBarItems(leading: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Done"){
                    self.saveData()
                    self.presentationMode.wrappedValue.dismiss()
                }.disabled(self.name.isEmpty || self.license.isEmpty))
        }
    }
    
    private func saveData(){
        guard let md = (physician != nil) ? physician:Physician(context: self.moc) else {print("could not create physician in form"); return}
        md.name = self.name
        md.license = self.license
        
        try? self.moc.save()
    }
}

struct PhysicianForm_Previews: PreviewProvider {
    static var previews: some View {
        PhysicianForm()
    }
}
