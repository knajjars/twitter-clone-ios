//
//  FeedController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/12/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftButtonNav()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlack
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func configureLeftButtonNav() {
        guard let user = self.user else {return}
        
        let profileImage = UIImageView()
        profileImage.setDimensions(width: 32, height: 32)
        profileImage.layer.cornerRadius = 32 / 2
        profileImage.layer.masksToBounds = true
        
        profileImage.sd_setImage(with: user.profileImageURL, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }
}
