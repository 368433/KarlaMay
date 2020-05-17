//
//  ClinicalVisitDotView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalVisitDotView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var showEditVisitForm = false
    var visit: ClinicalVisit
    
    var body: some View {
//        GeometryReader { g in
            VStack{
                Text(self.visit.actLabel).fontWeight(.semibold).minimumScaleFactor(0.4)
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
                Text(self.visit.shortDate).font(.footnote)
        }.lineLimit(1)
//        }
    }
}

struct ClinicalVisitDotView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalVisitDotView(visit: DummyData.dummyClinicalVisit)
    }
}
