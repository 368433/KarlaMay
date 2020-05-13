//
//  ExtensionClinicalWork.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-11.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
import CoreData

extension ClinicalWork: Identifiable {
    
    var chronologicEpisodesOfCare: [EpisodeOfCare] {
        if let eocs = self.episodesOfCare as? Set<EpisodeOfCare> {
            return eocs.sorted()
        } else { return []}
    }
    
    func setAsMainList(confirm: Bool){
        
        //check if UniqueTag "mainList" exists
        let fetchRequest = FetchRequest<UniqueTag>(entity: UniqueTag.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "title", UniqueTagsOptions.mainClinicalList.associatedLabel))
        
        //if exists, assign its clin work attribute to this list
        if let mainTag = fetchRequest.wrappedValue.first {
            mainTag.clinicalWork = self
            try? self.managedObjectContext?.save()
        } else {
            //if does not exist, create it and assign its clin work to this list
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let uTag = UniqueTag(context: moc)
            uTag.title = UniqueTagsOptions.mainClinicalList.associatedLabel
            uTag.clinicalWork = self
            try? moc.save()
        }
        
    }
    
}
