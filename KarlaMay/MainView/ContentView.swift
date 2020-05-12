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
                    Text("Main clinical work list")
                    Text("All clinical work list")
                    Text("Patients")
                    Text("Tags")
                }
                Section(header: Text("Laboratory")){
                    Text("Protocols & meetings")
                }
                Section(header: Text("Administrative")){
                    Text("PCI")
                    Text("Antimicrobial Stewardship")
                    Text("Teaching")
                    Text("Other meetings")
                    Text("Maintenance Of Certification")
                    Text("Billing")
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
        ContentView()
    }
}
