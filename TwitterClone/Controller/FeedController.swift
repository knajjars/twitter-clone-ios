//
//  FeedController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/12/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
