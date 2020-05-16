//
//  ICDData.swift
//  ICDLookup
//
//  Created by quarticAIMBP2018 on 2020-05-09.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import SwiftUI
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

enum ICDSearchError: Error {
    case invalidToken
    case invalidURL
    case emptyQuery
}

class ICDLinearizationSearch {
    lazy var apiToken = APIToken()
    let linearizationName: String = "mms"
    let releaseId = "2019-04"
    var subtreesFilter: String = ""
    var includeKeywordResult = false
    var useFlexisearch = false
    var apiVersion = "v2"
    var searchLanguage = "en"
    
    func search(query: String, completion: @escaping (ICDSearchResponse) -> ()) throws {
        guard apiToken.isValid() else {throw TokenFetchingError.invalidToken(comment: "in search function guard")}
        guard !query.isEmpty else {throw ICDSearchError.emptyQuery}
        let searchQuery = FormatQueryForICD11API(query: query)
        let apiEndPoint = "https://id.who.int/icd/release/11/\(releaseId)/\(linearizationName)/search?q=\(searchQuery)&includeKeywordResult=\(includeKeywordResult)&useFlexisearch=\(useFlexisearch)&flatResults=true"
        guard let url = URL(string: apiEndPoint) else {throw ICDSearchError.invalidURL}
        
        // Add headers and create request
        let searchHeaders = [ "Authorization":  "Bearer \(apiToken.value)", "Accept": "application/json", "Accept-Language": searchLanguage, "API-Version": apiVersion]
        var request = URLRequest(url: url)
        for (key, value) in searchHeaders {request.addValue(value, forHTTPHeaderField: key)}
    
        // Create search network task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {print(error ?? "Unknown error"); return}
            guard let HTTPresponse = response as? HTTPURLResponse else {return}
            if HTTPresponse.statusCode == 200 {
                if let data = data, let decodedResponse = try? JSONDecoder().decode(ICDSearchResponse.self, from: data){
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } else { print("error in data or decoding")}
            } else { print(HTTPresponse.statusCode) }
        }.resume()
    }
    
    private func FormatQueryForICD11API(query: String) -> String {
        var result = query.replacingOccurrences(of: "%", with: "%25")
        result = result.replacingOccurrences(of: " ", with: "%20")
        return result
    }
}
