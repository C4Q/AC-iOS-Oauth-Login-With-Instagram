//
//  InstagramAPI.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

protocol InstagramAPIDelegate: class {
    func didReceiveToken(_ instagramAPI: InstagramAPI)
    func didReceiveUserInfo(_ instagramAPI: InstagramAPI, userInfo: InstagramUserInfo)
}

class InstagramAPI {
    public weak var delegate: InstagramAPIDelegate?
    
    public func performDataTask(urlRequest: URLRequest,
                                httpMethod: String,
                                completion: @escaping(Error?, Data?)->Void) {
        NetworkSession.urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(error, nil)
            } else if let data = data {
                completion(nil, data)
            }
        }.resume()
    }
    
    public func tokenExchange(code: String) {
        var urlRequest = URLRequest(url: URL(string: InstagramKeys.tokenExchangeURL)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = "\(InstagramKeys.httpBody)\(code)".data(using: .utf8)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        performDataTask(urlRequest: urlRequest, httpMethod: "POST") { (error, data) in
            if let error = error {
                print("tokenExchange error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let token = try decoder.decode(InstagramToken.self, from: data)
                    print("token: \(token.access_token)")
                    UserSession.shared.setToken(token: token.access_token)
                    self.delegate?.didReceiveToken(self)
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }
    }
    
    public func userInfo() {
        guard let access_token = UserSession.shared.getToken() else { print("token is nil"); return }
        let urlRequest = URLRequest(url: URL(string: "https://api.instagram.com/v1/users/self/?access_token=\(access_token)")!)
        performDataTask(urlRequest: urlRequest, httpMethod: "GET") { (error, data) in
            if let error = error {
                print("userInfo error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let userInfo = try decoder.decode(InstagramUserInfo.self, from: data)
                    print("userInfo: \(userInfo)")
                    self.delegate?.didReceiveUserInfo(self, userInfo: userInfo)
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }
        
    }
}
