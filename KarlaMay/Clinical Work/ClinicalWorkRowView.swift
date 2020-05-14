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
                self.clinicalWork.isMainList.toggle()
                self.isMainList.toggle()
                if self.clinicalWork.isMainList {self.clinicalWork.isActive = true}
                try? self.moc.save()
            }){ Image(systemName: isMainList ? "star.fill" : "star") }
            
            Button(action: {
                self.clinicalWork.isActive.toggle()
                self.isActive.toggle()
                if !self.clinicalWork.isActive {self.clinicalWork.isMainList = false}
                try? self.moc.save()
            }){ Image(systemName: isActive ? "archivebox" : "archivebox.fill")}.padding([.leading, .trailing])
        }
    }
}

struct ClinicalWorkRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalWorkRowView(clinicalWork: DummyData.dummyClinicalWork, isMainList: true, isActive: false)
    }
}
