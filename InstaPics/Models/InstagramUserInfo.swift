//
//  InstagramUserInfo.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct Counts: Codable {
    let media: Int
    let follows: Int
    let followed_by: Int
}

struct UserData: Codable {
    let id: String
    let username: String
    let profile_picture: URL
    let full_name: String
    let bio: String
    let website: URL
    let is_business: Bool
    let counts: Counts
}

struct Meta: Codable {
    let code: Int
}

struct InstagramUserInfo: Codable {
    let data: UserData
    let meta: Meta
}
