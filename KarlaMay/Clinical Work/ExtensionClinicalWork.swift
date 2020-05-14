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
    
    /// TESTING CODE TO LINK TAG BEHAVIOUR TO MAIN LIST FLAGGING  - NOT IN USE
    func setAsMainList(confirm: Bool){
        
        //check if UniqueTag "mainList" exists
//        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let kp = NSExpression(forKeyPath: \UniqueTag.title)
        let val = NSExpression(forConstantValue: UniqueTagsOptions.mainClinicalList.associatedLabel)
        let predicate = NSComparisonPredicate(leftExpression: kp, rightExpression: val, modifier: .direct, type: .equalTo, options: .init())
        let fetchRequest = FetchRequest<UniqueTag>(entity: UniqueTag.entity(), sortDescriptors: [], predicate: predicate)
        
        print(fetchRequest)
        
        //if exists, assign its clin work attribute to this list
//        if !fetchRequest.wrappedValue.isEmpty {
//            print("there is a unique tag")
//            if confirm {
//                mainTag.clinicalWork = self
//            } else {
//                mainTag.clinicalWork = nil
//            }
//        } else {
//            //UniqueTag does not exist, create it and assign its clin work to this list
//            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let uTag = UniqueTag(context: moc)
//            uTag.title = UniqueTagsOptions.mainClinicalList.associatedLabel
//            uTag.clinicalWork = self
//            try? moc.save()
//        }
        
    }
    
}
