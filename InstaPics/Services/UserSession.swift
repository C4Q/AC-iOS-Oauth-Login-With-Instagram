//
//  UserSession.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

private struct UserKeys {
    static let Token = "Token"
}

class UserSession {
    private init(){}
    static let shared = UserSession()
    
    public func clearUserContent() {
        removeToken()
    }
}

extension UserSession {
    public func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: UserKeys.Token)
    }
    
    public func getToken() -> String? {
        return UserDefaults.standard.object(forKey: UserKeys.Token) as? String
    }
    
    private func removeToken() {
        UserDefaults.standard.set(nil, forKey: UserKeys.Token)
    }
}
