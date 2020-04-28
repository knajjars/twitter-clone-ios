//
//  Tweet.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/24/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import Foundation

struct Tweet {
    let caption: String
    let likes: Int
    let retweetsCount: Int
    var timestamp: Date!
    let uid: String
    let tweetId: String
    let user: User
    
    init(user: User, tweetId: String, dictionary: [String: Any]) {
        self.tweetId = tweetId
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetsCount = dictionary["retweetsCount"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.user = user
        guard let timestamp = dictionary["timestamp"] as? Double else {return}
        self.timestamp = Date(timeIntervalSince1970: timestamp)
    }
}
