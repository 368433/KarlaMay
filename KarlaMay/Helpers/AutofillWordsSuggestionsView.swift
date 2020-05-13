//
//  AutofillWordsSuggestionsView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-13.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct AutofillWordsSuggestionsView: View {
    
    private var wordsSuggestion: [String] = ["Garde", "Ambulatoire", "PCI", "Stewardship", "Autre", "Clinique", "Enseignement"]
    
    var action: (_ word:String) -> Void
    
    init(action: @escaping (_ word: String) -> Void){
        self.action = action
    }
    
    init(wordList: [String], action: @escaping (_ word: String) -> Void){
        self.wordsSuggestion = wordList
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Words suggestions").foregroundColor(.secondary).font(.footnote)
            ScrollView(.horizontal) {
                HStack{
                    ForEach(0..<wordsSuggestion.count) { index in
                        Button(self.wordsSuggestion[index]){
                            self.action(self.wordsSuggestion[index])
                        }.padding(8)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                        .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

struct AutofillWordsSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        AutofillWordsSuggestionsView(action: {word in})
    }
}
