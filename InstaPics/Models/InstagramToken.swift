//
//  InstagramToken.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct InstaUser: Codable {
    let id: String
    let username: String
    let profile_picture: URL
    let full_name: String
    let bio: String
    let website: URL
    let is_business: Bool
}

struct InstagramToken: Codable {
    let access_token: String
    let user: InstaUser
}
