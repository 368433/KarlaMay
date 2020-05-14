//
//  ClinicalWorkRowView.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI

struct ClinicalWorkRowView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: UniqueTag.entity(),
        sortDescriptors: [],
        predicate: NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: \UniqueTag.title),
            rightExpression: NSExpression(forConstantValue: UniqueTagsOptions.mainClinicalList.associatedLabel) ,
            modifier: .direct,
            type: .equalTo,
            options: [])) var uTag: FetchedResults<UniqueTag>
    
    var clinicalWork: ClinicalWork
    @State var isMainList: Bool
    @State var isActive: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(self.clinicalWork.title ?? "No title").font(.headline)
                Text("Created on: " + (self.clinicalWork.startDate?.toString ?? "No date set")).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
            
            Button(action: {
                self.isMainList.toggle()
                self.setMainList(confirm: self.isMainList)
                try? self.moc.save()
            }){ Image(systemName: isMainList ? "star.fill" : "star") }
            
            Button(action: {
                self.clinicalWork.isActive.toggle()
                self.isActive.toggle()
                if !self.isActive {self.clinicalWork.setAsMainList(confirm: false)}
                try? self.moc.save()
            }){ Image(systemName: isActive ? "archivebox" : "archivebox.fill")}.padding([.leading, .trailing])
        }
    }
    
    private func setMainList(confirm: Bool){
        guard let uTag = uTag.first else {
            print("here")
            let tag = UniqueTag(context: moc)
            tag.title = UniqueTagsOptions.mainClinicalList.associatedLabel
            tag.clinicalWork = clinicalWork
            return
        }
        if confirm {
            print("there")
            uTag.clinicalWork?.isMainList = false
            uTag.clinicalWork = clinicalWork
            clinicalWork.isMainList = true
        } else {
            uTag.clinicalWork = nil
            clinicalWork.isMainList = false
        }
        
    }
}

struct ClinicalWorkRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkRowView(clinicalWork: DummyData.dummyClinicalWork, isMainList: true, isActive: false)
    }
}
