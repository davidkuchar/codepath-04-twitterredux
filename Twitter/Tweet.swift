//
//  Tweet.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetedByUser: User?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
//        println(dictionary)
        
        if let retweetedDictionary = dictionary["retweeted_status"] as? NSDictionary {
            
//            println("retweeted by: \(retweetedDictionary)")
            
            user = User(dictionary: retweetedDictionary["user"] as! NSDictionary)
            text = retweetedDictionary["text"] as? String
            retweetedByUser = User(dictionary: dictionary["user"] as! NSDictionary)
            
            println("tweet by \(user!.name). retweeted by \(retweetedByUser!.name)")
        } else {
            user = User(dictionary: dictionary["user"] as! NSDictionary)
            text = dictionary["text"] as? String
        }
        
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
