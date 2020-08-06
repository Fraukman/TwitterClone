//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Juan Souza on 17/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var timestamp: String {
        let formater = DateComponentsFormatter()
        formater.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formater.maximumUnitCount = 1
        formater.unitsStyle = .abbreviated
        let now = Date()
        return formater.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString?{
        return attributedText(withValue: tweet.retweetCount, text: " Retweets")
    }
    
    var likesAttributedString: NSAttributedString?{
        return attributedText(withValue: tweet.likes, text: " Likes")
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username) ∙ \(timestamp)", attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: "\(text)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
    
}
