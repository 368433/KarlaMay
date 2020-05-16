//
//  DiagnosisRow.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-10.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ICDDiagnosisRow: View {
    var diagnosis: ICDDestinationEntity
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(diagnosis.theCode).fontWeight(.bold).foregroundColor(.secondary)
                Text(diagnosis.titleStripped)
                Text(diagnosis.matchingPVsJoined).foregroundColor(.secondary).font(.footnote)
            }.padding()
            Spacer()
            Image(systemName: "info.circle").font(.system(size: 20)).padding()
        }.background(Color(UIColor.systemGray6))
        .cornerRadius(5)
        .shadow(radius: 3)
            .padding()
    }
}

struct DiagnosisRow_Previews: PreviewProvider {
    static var previews: some View {
        let dx = ICDDestinationEntity(id: "test", title: "test", score: 39, titleIsASearchResult: true, theCode: "test", chapter: "tewt", matchingPVs: [])
        return ICDDiagnosisRow(diagnosis: dx)
    }
}
