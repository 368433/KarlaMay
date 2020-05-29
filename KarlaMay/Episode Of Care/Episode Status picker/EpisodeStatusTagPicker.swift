//
//  EpisodeStatusTagPicker.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-28.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpisodeStatusTagPicker: View {
    
    @Binding var status: EpocStatus
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(EpocStatus.allCases, id: \.self) { status in
                    Text(status.label).font(.caption)
                        .padding(6)
                        .foregroundColor(self.status == status ? Color.white:Color.black)
                        .background(self.status == status ? Color.red:Color(UIColor.systemGray5))
                        .clipShape(Capsule())
                        .onTapGesture {
                            self.status = status
                    }
                }
            }.padding(5)
        }
    }
}

//struct EpisodeStatusTagPicker_Previews: PreviewProvider {
//    @State var status: EpocStatus
//    static var previews: some View {
//        EpisodeStatusTagPicker(status: $status)
//    }
//}
