//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 5/4/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    private let underlineFilter: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private let profileFilterView = ProfileFilterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.addSubview(backButton)
        view.backgroundColor = .twitterBlue
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .twitterWhite
        iv.layer.borderWidth = 4
        iv.layer.borderColor = UIColor.twitterBlack.cgColor
        
        return iv
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Loading...", for: .normal)
        button.layer.borderColor = UIColor.twitterWhite.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterWhite, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleFollowClick), for: .touchUpInside)
        
        return button
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "My Name Test"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@myUserName"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a label with more than one line, only for test purposes"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileFilterView.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        addSubview(profileImage)
        profileImage.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImage.setDimensions(width: 80, height: 80)
        profileImage.layer.cornerRadius = 80 / 2
        
        addSubview(followButton)
        followButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
        followButton.setDimensions(width: 100, height: 36)
        followButton.layer.cornerRadius = 36 / 2
        
        let userDetailsStack = UIStackView(arrangedSubviews: [fullNameLabel,
                                                              userNameLabel,
                                                              bioLabel])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fillProportionally
        userDetailsStack.spacing = 4
        addSubview(userDetailsStack)
        userDetailsStack.anchor(top: profileImage.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        addSubview(profileFilterView)
        profileFilterView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        addSubview(underlineFilter)
        underlineFilter.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3 , height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectores
    @objc func handleDismiss() {
        print("DEBUG: dismiss clicked")
    }
    
    @objc func handleFollowClick() {
        print("DEBUG: follow clicked")
    }
    
}

//MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else {return}
        let x = cell.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.underlineFilter.frame.origin.x = x
        }
    }
    
    
}
