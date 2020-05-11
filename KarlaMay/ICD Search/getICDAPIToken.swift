//
//  getICDAPIToken.swift
//  ICDLookup
//
//  Created by quarticAIMBP2018 on 2020-05-09.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation


class APIToken {
    let ClientId = "dabb9f14-20a4-4b3e-b721-bdf138c12a82_8322f7f3-3fa6-4c1f-9734-3affe74a53de"
    let ClientSecret = "0qlkl00Ymzg2m62UNILynwZfuafYBWBXbQrNj65h4bw="
    let tokenEndpoint = "https://icdaccessmanagement.who.int/connect/token"
    let userDefaultsTokenKey = "TokenData"
    
    var value = ""
    var tokenValue: TokenValue?
    
    init(){
        setupToken()
    }
    
    func setupToken(){
        do {
            try setTokenValue()
        }catch {
            print(error)
            getICDAPIToken()
        }
    }
    
    func isValid() -> Bool{
        if let tokenValue = tokenValue {
            return tokenValue.isValid()
        } else {
            return false
        }
    }
    
    func setTokenValue() throws {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsTokenKey) else {throw TokenFetching.noneInUserDefaults}
        guard let tokenValue = try? JSONDecoder().decode(TokenValue.self, from: data) else {throw TokenFetching.unableToDecode}
        guard tokenValue.isValid() else {throw TokenFetching.invalidToken(comment: "in setTokenValue func")}
        self.tokenValue = tokenValue
        self.value = tokenValue.icdAPIToken.accessToken
    }
}

enum TokenFetching: Error, LocalizedError{
    case noneInUserDefaults
    case unableToDecode
    case invalidToken(comment: String)
}

struct TokenValue: Codable {
    var dateCreated = Date()
    var icdAPIToken: ICDAPIToken
    func isValid() -> Bool{
        return Date().timeIntervalSince(dateCreated) < Double(icdAPIToken.expiresIn)
    }
}

// Encodes the server response when asking for token
struct ICDAPIToken: Codable {
    var accessToken: String
    var expiresIn: Int
    var tokenType: String
}

extension APIToken {
    func getICDAPIToken(){
        guard let endpoint = URL(string: tokenEndpoint) else {return}
        guard let credentials = "grant_type=client_credentials".data(using: String.Encoding.utf8) else {return}
        guard let clientID = "&client_id=\(ClientId)".data(using: String.Encoding.utf8) else {return}
        guard let secret = "&client_secret=\(ClientSecret)".data(using: String.Encoding.utf8) else {return}
        var request = URLRequest(url: endpoint)
        request.allHTTPHeaderFields = ["content-type": "application/x-www-form-urlencoded"]
        request.httpBody = credentials + clientID + secret
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            guard error == nil else { print(error?.localizedDescription ?? "Error in linearization task"); return}
            guard let HTTPresponse = response as? HTTPURLResponse else {return}
            
            if HTTPresponse.statusCode == 200, let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let token = try? decoder.decode(ICDAPIToken.self, from: data) {
                    let value = TokenValue(icdAPIToken: token)
                    if let jsonData = try? JSONEncoder().encode(value){
                        UserDefaults.standard.set(jsonData, forKey: self.userDefaultsTokenKey)
                        self.setupToken()
                    }
                } else { print("could not decode data to icdapitoken object")}
            } else { print(HTTPresponse.statusCode) }
        }.resume()
    }
}

