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
    @FetchRequest(entity: ClinicalWork.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "isMainList", true)) var mainClinicalWork: FetchedResults<ClinicalWork>
    
    var body: some View {
        List{
            ForEach(self.mainClinicalWork, id:\.self){ clinicalWork in
                Text("test")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
