//
//  ContentView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-10.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Clinical")){
                    ForEach(ClinicalWorkCategory.allCases, id:\.self){ clinCat in
                        HStack(spacing: 20){
                            clinCat.image.foregroundColor(Color.blue).frame(width:20, height: 20)
                            Text(clinCat.rawValue)
                        }
                    }
                }
                Section(header: Text("Laboratory")){
                    ForEach(LaboratoryWorkCategory.allCases, id:\.self){ lab in
                        HStack(spacing: 20){
                            lab.image.foregroundColor(Color.green).frame(width:20, height: 20)
                            Text(lab.rawValue)
                        }
                    }
                }
                Section(header: Text("Administrative")){
                    ForEach(AdministrativeWorkCategory.allCases, id:\.self){ admin in
                        HStack(spacing: 20){
                            admin.image.foregroundColor(Color.gray).frame(width:20, height: 20)
                            Text(admin.rawValue)
                        }
                    }
                }
                Section(header: Text("Academic")){
                    ForEach(AcademicCategory.allCases, id:\.self){ acad in
                        HStack(spacing: 20){
                            acad.image.foregroundColor(Color.gray).frame(width:20, height: 20)
                            Text(acad.rawValue)
                        }
                    }
                }
                Section(header: Text("Analytics")){
                    Text("Data analysis")
                }
            }
            .navigationBarTitle("Main view")
            .navigationBarItems(trailing:
                HStack{
                    Group{
                        Button(action:{}){
                            Image(systemName: "person.badge.plus")
                        }
                        Button(action:{}){
                            Image(systemName: "gear")
                        }
                    }.padding().font(.system(size: 20))
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView().environment(\.colorScheme, .dark)
            ContentView().environment(\.colorScheme, .light)
        }
    }
}
