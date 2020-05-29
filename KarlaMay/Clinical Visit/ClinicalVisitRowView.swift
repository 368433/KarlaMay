//
//  ClinicalVisitRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

struct ClinicalVisitRowView: View {
    var clinicalVisit: ClinicalVisit
    
    var body: some View {
        HStack(alignment:.center){
            Text(clinicalVisit.actLabel).foregroundColor(.primary)
            Text(clinicalVisit.dateLabel).foregroundColor(.secondary)
        }
    }
}

struct ClinicalVisitRowView_Previews: PreviewProvider {
    static var previews: some View {
        return ClinicalVisitRowView(clinicalVisit: DummyData.dummyClinicalVisit)
    }
}
