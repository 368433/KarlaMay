//
//  VisitSectionView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-18.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct VisitSectionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var visits: VisitsResults
    @State private var showClinicalVisitForm = false
    
    var body: some View {
        Section(header: VStack(alignment: .leading, spacing:0){
            HStack {Text("Visits");Spacer();Button(action: {self.showClinicalVisitForm.toggle()}){AddIcon()}}
            if visits.results.isEmpty {Text("Currently no visits registered")}})
        {
            ForEach(visits.results, id: \.self){ visit in
                Text(visit.actType ?? "No act type")
            }.onDelete { (indexSet) in
                for index in indexSet{
                    self.visits.results.remove(at: index)
                }
            }
        }
        .sheet(isPresented: $showClinicalVisitForm) {
            ClinicalVisitForm(){ (visit) in DispatchQueue.main.async {self.visits.results.append(visit)} }.environment(\.managedObjectContext, self.moc)
        }
    }

}

struct VisitSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VisitSectionView(visits: VisitsResults())
    }
}
