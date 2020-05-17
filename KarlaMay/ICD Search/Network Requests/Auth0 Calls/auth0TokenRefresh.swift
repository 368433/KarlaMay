//
//  RefreshTokenWHOICDAPI.swift
//  KarlaMay
//  source: https://auth0.com/docs/flows/guides/auth-code/call-api-auth-code
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation


func auth0TokenRefresh(clientID: String,token: String, endPoint: String, completion: @escaping (AuthOTokenResponsePayload)->()){
    let headers = ["content-type": "application/x-www-form-urlencoded"]

    guard let endpoint = URL(string: endPoint) else {return}
    guard let grantType = "grant_type=refresh_token".data(using: String.Encoding.utf8) else {return}
    guard let clientID = "&client_id=\(clientID)".data(using: String.Encoding.utf8) else {return}
    
    var request = URLRequest(url: endpoint)
    request.allHTTPHeaderFields = headers
    request.httpBody = grantType + clientID
    request.httpMethod = "POST"
    
//    postData.append("&refresh_token=YOUR_REFRESH_TOKEN".data(using: String.Encoding.utf8)!)


    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
          print(httpResponse.statusCode)
        }
    })

    dataTask.resume()
}
