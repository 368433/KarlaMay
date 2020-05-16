//
//  CallWHOICDAPI.swift
//  KarlaMay
//  source: https://auth0.com/docs/flows/guides/auth-code/call-api-auth-code
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

//import Foundation
//
//func callWHOICDAPI(){
//
//    let headers = [
//      "content-type": "application/json",
//      "authorization": "Bearer ACCESS_TOKEN"
//    ]
//
//    let request = NSMutableURLRequest(url: NSURL(string: "https://myapi.com/api")! as URL,
//                                            cachePolicy: .useProtocolCachePolicy,
//                                        timeoutInterval: 10.0)
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//      if (error != nil) {
//        print(error)
//      } else {
//        let httpResponse = response as? HTTPURLResponse
//        print(httpResponse)
//      }
//    })
//
//    dataTask.resume()
//}
