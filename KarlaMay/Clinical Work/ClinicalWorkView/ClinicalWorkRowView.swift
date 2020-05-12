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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ClinicalWorkRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkRowView(clinicalWork: DummyData.dummyClinicalWork)
    }
}
