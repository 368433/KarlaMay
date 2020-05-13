//
//  DynamicallyFilteredList.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-13.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//
//  Copied from Hackingwithswift Rights to Paul Hudson and adapted

import Foundation
import SwiftUI
import CoreData

struct DynamicallyFilteredList: View {
    @Environment(\.managedObjectContext) var moc
    var fetchRequest: FetchRequest<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        //List{
            ForEach(fetchRequest.wrappedValue, id: \.self) { filteredObject in
                self.content(filteredObject)
            }.onDelete(perform: deleteItem)
        //}
    }
    
    init(sortingCriteria: [NSSortDescriptor], predicate: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortingCriteria, predicate: predicate)
        self.content = content
    }
    
    private func deleteItem(at offsets: IndexSet){
        for index in offsets {
            let item = fetchRequest.wrappedValue[index]
            moc.delete(item)
        }
        do {try moc.save()}
        catch {/*handle the Core Data error */}
    }
}
