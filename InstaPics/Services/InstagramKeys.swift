//
//  InstagramAPI.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct InstagramKeys {
    private static let clientId = "{ENTER CLIENT ID HERE}"
    private static let clientSecret = "ENTER CLIENT SECRET HERE"
    private static let redirectURI = "ENTER REDIRECT URI HERE"
    private static let scope = ""
    private static let state = "94q5937297459137957"
    
    public static let authURL = "https://api.instagram.com/oauth/authorize/?client_id=\(InstagramKeys.clientId)&redirect_uri=\(InstagramKeys.redirectURI)&response_type=code&state=\(InstagramKeys.state)"
    public static let tokenExchangeURL = "https://api.instagram.com/oauth/access_token"
    public static let httpBody = "grant_type=authorization_code&redirect_uri=\(InstagramKeys.redirectURI)&client_id=\(InstagramKeys.clientId)&client_secret=\(InstagramKeys.clientSecret)&code="
    
    
    // methods
    let userInfoMethod = "https://api.instagram.com/v1/users/self/?access_token="
    
}
