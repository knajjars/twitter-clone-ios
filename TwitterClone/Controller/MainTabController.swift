//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/12/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let controller = CreateTweetController(user: user)
        let createTweet = UINavigationController(rootViewController: controller)
        
        present(createTweet, animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        //        logOutUser()
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - Helpers
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { (user) in
            self.user = user
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            fatalError("error logging user out \(error)")
        }
    }
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        let feed = FeedController()
        let feedImage = UIImage(named: "home_unselected")
        let feedNav = generateNavigationController(image: feedImage, rootViewController: feed)
        
        let explore = ExploreController()
        let exploreImage = UIImage(named: "search_unselected")
        let exploreNav = generateNavigationController(image: exploreImage, rootViewController: explore)
        
        let notification = NotificationController()
        let notificationImage = UIImage(named: "like_unselected")
        let notificationNav = generateNavigationController(image: notificationImage, rootViewController: notification)
        
        let conversation = ConversationController()
        let conversationImage = UIImage(named: "mail_unselected")
        let conversationNav = generateNavigationController(image: conversationImage, rootViewController: conversation)
        
        viewControllers = [feedNav, exploreNav, notificationNav, conversationNav]
        
        UITabBar.appearance().barTintColor = .twitterBlack
        
    }
    
    func generateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .twitterBlack
        
        return nav
    }
}
