//
//  auth0APICall.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

func auth0APICall(){

    let headers = [
      "content-type": "application/json",
      "authorization": "Bearer ACCESS_TOKEN"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://myapi.com/api")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print("test")
      } else {
//        let httpResponse = response as? HTTPURLResponse
        print("test")
      }
    })

    dataTask.resume()
}
