//
//  TweetService.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/21/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func createTweet(caption: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = [
            "caption": caption,
            "likes": 0,
            "retweets": 0,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "uid": uid
            ] as [String: Any]
        
        TWEET_REF.childByAutoId().setValue(values, withCompletionBlock: completion)
    }
    
    func fetchTweet(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        TWEET_REF.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let tweetId = snapshot.key
            guard let uid = dictionary["uid"] as? String else {return}
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
