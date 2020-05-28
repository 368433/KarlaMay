//
//  EpocSectionView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct EpocSectionView: View {
    @ObservedObject var epoc: EpisodeOfCare
    @State private var showStartDate = false
//    @State private var epocStatus: EpocStatus = .inpatient

    var body: some View {
        /// EPISODE OF CARE
        HStack {
            Color.green.frame(width:8)
            VStack(alignment: .leading){
                Text("Episodes Of Care")
                Picker(selection: self.$epoc.epocStatus, label: Text("Status")){
                    ForEach(EpocStatus.allCases, id: \.self){ status in
                        Text(status.rawValue).tag(status)
                    }
                    }.pickerStyle(SegmentedPickerStyle())
                VStack(spacing: 0){
                    HStack{
                        Text("Start Date")
                        Spacer()
                        Text((epoc.startDate ?? Date()).toString)
                    }.onTapGesture {
                        self.showStartDate.toggle()
                    }
                    if showStartDate {
                        DatePicker(selection: self.$epoc.startDate ?? Date(), in:...Date(), displayedComponents: .date){Text("Start Date")}
                    }
                }
            }
        }.cornerRadius(5)
//            .onAppear(perform: {
//                self.epocStatus = EpocStatus.forEpoc(self.epoc)
//            })
//            .onDisappear {
//                self.epoc.setStatus(to: self.epocStatus)
//        }
    }
}
//
//struct EpocSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EpocSectionView()
//    }
//}
