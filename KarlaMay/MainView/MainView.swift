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
        List{
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
        }.listStyle(GroupedListStyle())
            
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
