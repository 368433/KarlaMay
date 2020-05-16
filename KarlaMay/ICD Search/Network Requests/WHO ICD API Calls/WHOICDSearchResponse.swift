//
//  WHOICDSearchResponse.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct ICDSearchResponse: Codable {
    var destinationEntities: [ICDDestinationEntity]
    var sortedResults: [ICDDestinationEntity] {
        return destinationEntities.sorted { (entity1, entity2) -> Bool in
            entity1.score > entity2.score
        }
    }
}

struct ICDDestinationEntity: Codable, Identifiable, Hashable {
    var id: String // the unique entity endpoint coded in ICD 11
    var title: String
    var score: Double
    var titleIsASearchResult: Bool
    var theCode: String
    var chapter: String
    var matchingPVs: [ICDPropertyValues]
    var titleStripped: String {
        return title.StripHTMLTags()
    }
    var matchingPVsJoined: String {
        var result = ""
        var labels = matchingPVs.makeIterator()
        result += (labels.next()?.label.StripHTMLTags() ?? "") + " "
        return result
    }
}

struct ICDPropertyValues: Codable, Hashable {
    var label: String
}

class WHOICDResponseDecoder: ObservableObject {
    @Published var results: [ICDDestinationEntity] = []
    
    var data: Data? {
        didSet{
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ICDSearchResponse.self, from: data){
                    results = decodedResponse.sortedResults
                } else {
                    print("unable to decode Json icd search response")
                }
            }
        }
    }
}
