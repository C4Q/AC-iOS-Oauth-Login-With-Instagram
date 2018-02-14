//
//  LoginViewController.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let scheme = "InstaPics://"
    private let instagramAPI = InstagramAPI()
    
    private var authSession: SFAuthenticationSession?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        instagramAPI.delegate = self
    }
    
    // retrieve code from callbackURL
    private func getParam(url: URL, param: String) -> String? {
        guard let urlComponents = URLComponents(string: url.absoluteString) else { print("url is nil");return nil }
        return urlComponents.queryItems?.first{ $0.name == param }?.value
    }
    
    @IBAction func loginWithInstagram(_ sender: UIButton) {
        authSession = SFAuthenticationSession.init(url: URL(string:InstagramKeys.authURL)!, callbackURLScheme: scheme) { (callbackURL, error) in
            if let error = error {
                print("loginWithInstagram error: \(error)")
            } else if let callbackURL = callbackURL {
                print("callbackURL: \(callbackURL)")
                guard let code = self.getParam(url: callbackURL, param: "code") else { print("need a valid code"); return }
                print("code: \(code)")
                self.instagramAPI.tokenExchange(code: code)
            }
        }
        authSession?.start()
    }
    
    public static func storyboardInstance() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return loginViewController
    }
}

extension LoginViewController: InstagramAPIDelegate {
    func didReceiveToken(_ instagramAPI: InstagramAPI) {
        let profileVC = ProfileViewController.storyboardInstance()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    func didReceiveUserInfo(_ instagramAPI: InstagramAPI, userInfo: InstagramUserInfo) {}
}
