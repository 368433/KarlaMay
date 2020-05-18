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
        VStack(alignment: .leading){
            Text(diagnosis.titleLabel).foregroundColor(.primary)
            Text(diagnosis.icdCodeLabel).foregroundColor(.secondary).font(.caption)
        }.lineLimit(1)
    }
}

struct DiagnosisRowView_Previews: PreviewProvider {
    static var previews: some View {
        return DiagnosisRowView(diagnosis: DummyData.dummyDiagnosis)
    }
}
