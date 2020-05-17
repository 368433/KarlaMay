//
//  ClinicalWorkBanderoleView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkBanderoleView: View {
    var clinicalWork: ClinicalWork
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            VStack(alignment: .leading){
                Text("Start date")
                Text("End date")
                Text(clinicalWork.comments ?? "").foregroundColor(.secondary).lineLimit(2)
            }.font(.caption).padding()
            Spacer()
            HStack(spacing: 18){
                Button(action: {
                    self.clinicalWork.isActive.toggle()
                }) {
                    Image(systemName: self.clinicalWork.isActive ? "archivebox": "archivebox.fill")
                }
                Button(action: {
                    //show edit clinicalwork list
                }) {
                    Image(systemName: "gear")
                }
            }.padding(.trailing).font(.system(size: 20))
        }.background(Color(UIColor.systemGray6)).shadow(radius: 8).padding()
    }
}

struct ClinicalWorkBanderoleView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkBanderoleView(clinicalWork: DummyData.dummyClinicalWork)
    }
}
