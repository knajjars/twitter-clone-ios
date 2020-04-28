//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/27/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImage: URL? {
        return tweet.user.profileImageURL
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        
        return formatter.string(from: tweet.timestamp, to: now) ?? "0s"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.userName)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ∙ \(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(with tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
