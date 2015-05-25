//
//  Tweet.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id: String?
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetedByUser: User?
    var retweets: Int?
    var favorites: Int?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
//        println(dictionary)
        
        if let retweetedDictionary = dictionary["retweeted_status"] as? NSDictionary {
            id = retweetedDictionary["id"] as? String
            user = User(dictionary: retweetedDictionary["user"] as! NSDictionary)
            text = retweetedDictionary["text"] as? String
            retweets = retweetedDictionary["retweet_count"] as? Int
            favorites = retweetedDictionary["favorite_count"] as? Int
            retweetedByUser = User(dictionary: dictionary["user"] as! NSDictionary)
        } else {
            id = dictionary["id"] as? String
            user = User(dictionary: dictionary["user"] as! NSDictionary)
            text = dictionary["text"] as? String
            retweets = dictionary["retweet_count"] as? Int
            favorites = dictionary["favorite_count"] as? Int
        }
        
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    func timeSinceCreated() -> String {
        let elapsedTime = NSDate().timeIntervalSinceDate(createdAt!) as NSTimeInterval
        
        switch elapsedTime {
        case 0...60:
            let t = Int(round(elapsedTime))
            return "\(t)s"
        case 60...3600:
            let t = Int(round(elapsedTime/60))
            return "\(t)m"
        case 3600...86400:
            let t = Int(round(elapsedTime/3600))
            return "\(t)h"
        default:
            let dateString = NSDateFormatter.localizedStringFromDate(
                createdAt!,
                dateStyle: .ShortStyle,
                timeStyle: .NoStyle)
            return dateString
        }
    }
    
    func dateTimeCreated() -> String {
        let dateString = NSDateFormatter.localizedStringFromDate(
            createdAt!,
            dateStyle: .ShortStyle,
            timeStyle: .ShortStyle)
        return dateString
    }
    
    func retweet() {
        if let tweetId = id {
            TwitterClient.sharedInstance().retweetWithTweetId(tweetId, params: nil) { (tweet, error) -> () in
                if tweet != nil {
                    println("retweeted successfully! \(tweet)")
                } else {
                    println("error \(error)")
                }
            }
        }
    }
    
    func createFavorite() {
        if let tweetId = id {
            TwitterClient.sharedInstance().createFavoriteWithTweetId(tweetId, params: nil) { (tweet, error) -> () in
                if tweet != nil {
                    println("favorited successfully! \(tweet)")
                } else {
                    println("error \(error)")
                }
            }
        }
    }
    
    class func sendTweet(status: String) {
        TwitterClient.sharedInstance().tweetWithStatus(status, params: nil) { (tweet, error) -> () in
            if tweet != nil {
                println("tweeted successfully! \(tweet)")
            } else {
                println("error \(error)")
            }
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
