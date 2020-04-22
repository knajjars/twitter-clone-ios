//
//  CreateTweet.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/20/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//


import UIKit

class CreateTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    private let caption = CaptionTextView()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        caption.becomeFirstResponder()
    }
    
    //MARK: - Selectors
    
    @objc func handleTweet() {
        if !caption.text.isEmpty {
            TweetService.shared.createTweet(caption: caption.text) { (error, ref) in
                if let err = error {
                    print("DEBUG: issue creating tweet with error: \(err.localizedDescription)")
                    return
                }
                self.handleCancel()
            }
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlack
        
        configureNavController()
        
        profileImage.sd_setImage(with: user.profileImageURL, completed: nil)
        
        let stack = UIStackView(arrangedSubviews: [profileImage, caption])
        stack.axis = .horizontal
        stack.spacing = 16
        view.addSubview(stack)
        
        stack.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
    
    func configureNavController() {
        navigationController?.navigationBar.barTintColor = .twitterBlack
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    //MARK: - API
}
