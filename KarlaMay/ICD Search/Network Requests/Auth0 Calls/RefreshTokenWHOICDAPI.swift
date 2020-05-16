//
//  RefreshTokenWHOICDAPI.swift
//  KarlaMay
//  source: https://auth0.com/docs/flows/guides/auth-code/call-api-auth-code
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

//func refreshTokenWHOICDAPI(){
//    let headers = ["content-type": "application/x-www-form-urlencoded"]
//
//    let postData = NSMutableData(data: "grant_type=refresh_token".data(using: String.Encoding.utf8)!)
//    postData.append("&client_id=YOUR_CLIENT_ID".data(using: String.Encoding.utf8)!)
//    postData.append("&refresh_token=YOUR_REFRESH_TOKEN".data(using: String.Encoding.utf8)!)
//
//    let request = NSMutableURLRequest(url: NSURL(string: "https://YOUR_DOMAIN/oauth/token")! as URL,
//                                            cachePolicy: .useProtocolCachePolicy,
//                                        timeoutInterval: 10.0)
//    request.httpMethod = "POST"
//    request.allHTTPHeaderFields = headers
//    request.httpBody = postData as Data
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
