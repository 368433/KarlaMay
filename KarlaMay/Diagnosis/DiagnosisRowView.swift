//
//  DiagnosisRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

struct DiagnosisRowView: View {
    var diagnosis: Diagnosis
    var body: some View {
        VStack{
            Text(diagnosis.titleLabel)
        }
    }
}

struct DiagnosisRowView_Previews: PreviewProvider {
    static var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let dx = Diagnosis(context: moc)
        dx.title = "Pneumonia"
        dx.icdCode = "A23.2"
        dx.startDate = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 340000...2020000)))
        dx.endDate = Date(timeIntervalSinceNow: 3600)
        return DiagnosisRowView(diagnosis: dx)
    }
}
