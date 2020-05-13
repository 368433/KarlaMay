//
//  AutofillWordsSuggestionsView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-13.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct AutofillWordsSuggestionsView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(0..<10) { _ in
                    Text("test").font(.title)
                }
            }
        }
    }
}

struct AutofillWordsSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        AutofillWordsSuggestionsView()
    }
}
