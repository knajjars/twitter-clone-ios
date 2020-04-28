//
//  FeedController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/12/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    //MARK: - Properties
    private let tweetIdentifier = "TWEET_CELL_IDENTIFIER"
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var user: User? {
        didSet {
            configureLeftButtonNav()
        }
    }
    
    //MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweet { tweets in
            self.tweets = tweets
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlack
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
        collectionView.backgroundColor = .twitterBlack
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: tweetIdentifier)
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

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}
