//
//  RequestToken.swift
//  KarlaMay
//  source: https://auth0.com/docs/flows/guides/auth-code/call-api-auth-code
//  updated by me
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation

func requestToken(tokenEndpoint: String, grantType: String, clientID: String, clientSecret: String, authorizationCode: String? = nil, redirectUri: String? = nil, completion: @escaping (_ token: ICDAPIToken) -> ()) {
    guard let endpoint = URL(string: tokenEndpoint) else {return}
    guard let credentials = "grant_type=\(grantType)".data(using: String.Encoding.utf8) else {return}
    guard let clientID = "&client_id=\(clientID)".data(using: String.Encoding.utf8) else {return}
    guard let secret = "&client_secret=\(clientSecret)".data(using: String.Encoding.utf8) else {return}
    var request = URLRequest(url: endpoint)
    request.allHTTPHeaderFields = ["content-type": "application/x-www-form-urlencoded"]
    request.httpBody = credentials + clientID + secret
    request.httpMethod = "POST"
    
    /*
     for authorization code and redirect url adapt:
     postData.append("&code=YOUR_AUTHORIZATION_CODE".data(using: String.Encoding.utf8)!)
     postData.append("&redirect_uri=https://YOUR_APP/callback".data(using: String.Encoding.utf8)!)
     */
    
    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
        if let error = error {
            print(error.localizedDescription)
        } else if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let token = try? decoder.decode(ICDAPIToken.self, from: data) {
                    DispatchQueue.main.async {
                        completion(token)
                    }
                }
                print(String(decoding: data, as:UTF8.self))
            }
        } else {
            print("Unknown error")
        }
    }).resume()
    
}

/*
 Response format
 {
 "access_token": "eyJz93a...k4laUWw",
 "refresh_token": "GEbRxBN...edjnXbL",
 "id_token": "eyJ0XAi...4faeEoQ",
 "token_type": "Bearer"
 }
 */
