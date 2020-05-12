//
//  MainView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Clinical")){
                    Text("Main clinical work list")
                    Text("All clinical work list")
                }
                Section(header: Text("Laboratory")){
                    Text("Patients")
                    Text("Tags")
                }
            }
        .navigationBarTitle("Main view")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
