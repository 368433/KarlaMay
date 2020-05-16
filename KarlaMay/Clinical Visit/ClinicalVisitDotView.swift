//
//  ClinicalVisitDotView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalVisitDotView: View {
    var visit: ClinicalVisit
    
    var body: some View {
        VStack{
            Text(visit.actLabel).font(.caption)
                .padding(7)
                .background(Color.red)
                .foregroundColor(Color.white)
                .clipShape(Circle())
            Text(visit.shortDate).font(.footnote)
                .padding(9)
                .background(Color.red)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        }
    }
}

struct ClinicalVisitDotView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalVisitDotView(visit: DummyData.dummyClinicalVisit)
    }
}
