//
//  TweetService.swift
//  TwitterClone
//
//  Created by Juan Souza on 16/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation
import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = ["uid": uid,
                     "timestamp": Int(NSDate().timeIntervalSince1970),
                     "likes":0,
                     "retweets":0,
                     "caption": caption] as [String: Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }

    func fetchTweets(completion: @escaping([Tweet]) -> Void){
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            let tweetId = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user,tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
            
        }
    }

}
