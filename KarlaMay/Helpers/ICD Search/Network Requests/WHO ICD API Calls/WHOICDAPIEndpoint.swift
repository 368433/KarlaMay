//
//  WHOICDAPIEndpoint.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

struct WHOICDAPIEndpoint {
    let linearizationName: String = "mms"
    let releaseId = "2019-04"
    var subtreesFilter: String = ""
    var includeKeywordResult = false
    var useFlexisearch = false
    var apiVersion = "v2"
    var searchLanguage = "en"
    var searchQuery: String
    
    init(query: String){
        var result = query.replacingOccurrences(of: "%", with: "%25")
        result = result.replacingOccurrences(of: " ", with: "%20")
        self.searchQuery = result
    }
    
    func endPoint()->String{
        return "https://id.who.int/icd/release/11/\(releaseId)/\(linearizationName)/search?q=\(searchQuery)&includeKeywordResult=\(includeKeywordResult)&useFlexisearch=\(useFlexisearch)&flatResults=true"
    }
    
    func additionalHeaders() -> [String:String]{
        return ["Accept-Language": searchLanguage, "API-Version": apiVersion]
    }
}
