//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/24/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    public var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Test Text!!"
        
        return label
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        return button
    }()

    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .twitterBlack
        
        addSubview(profileImage)
        profileImage.anchor(top: topAnchor, left: leftAnchor, paddingTop: 18, paddingLeft:  12)
        
        infoLabel.text = "Khalil Najjar"
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: profileImage.topAnchor, left: profileImage.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 12)
        
        let separator = UIView()
        separator.backgroundColor = .systemGroupedBackground
        addSubview(separator)
        separator.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let tweet = self.tweet else {return}
        let viewModel = TweetViewModel(with: tweet)
        captionLabel.text = tweet.caption
        infoLabel.attributedText = viewModel.userInfoText
        profileImage.sd_setImage(with: viewModel.profileImage)
        
    }
    
    
    //MARK: - Selectors
    
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }
    
    @objc func handleLikeTapped() {
        
    }
    
    @objc func handleShareTapped() {
        
    }
}
