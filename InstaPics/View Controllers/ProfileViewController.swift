//
//  ProfileViewController.swift
//  InstaPics
//
//  Created by Alex Paul on 2/13/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    private let instagramAPI = InstagramAPI()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated:true);
        instagramAPI.delegate = self
        view.addSubview(profileImage)
        instagramAPI.userInfo()
    }
    
    public static func storyboardInstance() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return profileViewController
    }
    
    @IBAction private func logout() {
        UserSession.shared.clearUserContent()
        let loginVC = LoginViewController.storyboardInstance()
        navigationController?.viewControllers = [loginVC]
    }
}

extension ProfileViewController: InstagramAPIDelegate {
    func didReceiveToken(_ instagramAPI: InstagramAPI) {}
    
    func didReceiveUserInfo(_ instagramAPI: InstagramAPI, userInfo: InstagramUserInfo) {
        DispatchQueue.main.async {
            self.profileImage.kf.setImage(with: userInfo.data.profile_picture)
            self.navigationItem.title = userInfo.data.username
        }
    }
}
