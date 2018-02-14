//
//  NetworkSession.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

class NetworkSession {
    private init(){}
    static let shared = NetworkSession()
    static let urlSession = URLSession(configuration: .default)
}
