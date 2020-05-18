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
        HStack(alignment: .center, spacing: 3){
            Text(diagnosis.icdCodeLabel).foregroundColor(.secondary).font(.caption)
            Text(diagnosis.titleLabel).foregroundColor(.primary)
        }.lineLimit(1)
    }
}

struct DiagnosisRowView_Previews: PreviewProvider {
    static var previews: some View {
        return DiagnosisRowView(diagnosis: DummyData.dummyDiagnosis)
    }
}
