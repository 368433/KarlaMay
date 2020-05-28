//
//  DiagnosisCompactView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-27.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct DiagnosisCompactView: View {
    var diagnosis: Diagnosis
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(diagnosis.title ?? "Title n/a")
                .font(.caption)
                .lineLimit(2)
                .frame(width: 120)
                
            Text(diagnosis.icdCode ?? "Code n/a")
                .foregroundColor(.secondary)
                .font(.system(size: 10))
        }.padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct DiagnosisCompactView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisCompactView(diagnosis: DummyData.dummyDiagnosis)
    }
}
