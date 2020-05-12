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
                ForEach(MainViewSections.allCases, id: \.self){ msSection in
                    Section(header: Text(msSection.rawValue)){
                        ForEach(msSection.subcategories, id:\.self) { categ in
                            NavigationLink(destination: categ.destinationView.environment(\.managedObjectContext, self.moc)) {
                                HStack(spacing: 20){
                                    categ.image.foregroundColor(msSection.color).frame(width:20, height: 20)
                                    Text(categ.rawValue)
                                }
                            }
                        }
                    }
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
