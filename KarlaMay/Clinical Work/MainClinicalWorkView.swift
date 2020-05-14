//
//  MainClinicalWorkView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-12.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct MainClinicalWorkView: View {
    
    @FetchRequest(entity: UniqueTag.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "title", UniqueTagsOptions.mainClinicalList.associatedLabel )) var mainCWTag: FetchedResults<UniqueTag>
    
    var body: some View {
//        NavigationView{
            Group{
                if mainCWTag.count == 0 {
                    Text("no list")
                } else {
                    Text("list found")
                }
            }.onAppear(perform: test)
        .navigationBarTitle("Current Clinical Work")
        .navigationBarItems(trailing:
            Button(action: {
                //add form, for now adding dummy lists
                
            }){
                Image(systemName: "plus").padding()
        })
//        }
    }
    
    private func test(){
        print(mainCWTag.count)
    }
}


struct MainClinicalWorkView_Previews: PreviewProvider {
    static var previews: some View {
        MainClinicalWorkView()
    }
}
