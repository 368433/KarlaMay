//
//  ClinicalWorkRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkRowView: View {
    
    var clinicalWork: ClinicalWork
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(self.clinicalWork.title ?? "No title").font(.headline)
                Text("Created on: " + (self.clinicalWork.startDate?.toString ?? "No date set")).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {}){
                Image(systemName: "star")
            }
        }
    }
}

struct ClinicalWorkRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkRowView(clinicalWork: DummyData.dummyClinicalWork)
    }
}
