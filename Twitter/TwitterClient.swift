//
//  TwitterClient.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TwitterClient: BDBOAuth1RequestOperationManager {
   
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class func sharedInstance() -> TwitterClient {
        
        struct Static {
            static let twitterBaseURL = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterBaseURL") as! String
            static let twitterConsumerKey = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterConsumerKey") as! String
            static let twitterConsumerSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterConsumerSecret") as! String
            
            static let instance = TwitterClient(
                baseURL: NSURL(string: twitterBaseURL),
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            // println("Got home timeline: \(response)")
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])

            completion(tweets: tweets, error: nil)
        
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Error getting home timeline: \(error)")
            
            completion(tweets: nil, error: error)
        })
    }
    
    func tweetWithStatus(status: String, params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        var _params = params ?? NSDictionary()
        _params.setValue(status, forKey: "status")
        
        POST("1.1/statuses/update.json", parameters: _params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Got response from tweeting")
            
            var tweet = Tweet(dictionary: response as! NSDictionary)
            
            completion(tweet: tweet, error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error tweeting: \(error)")
                
                completion(tweet: nil, error: error)
        }
    }
    
    func retweetWithTweetId(tweetId: String, params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {

        POST("1.1/statuses/retweet/\(tweetId).json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Got response from retweeting")
            
            var tweet = Tweet(dictionary: response as! NSDictionary)
            
            completion(tweet: tweet, error: nil)
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Error retweeting: \(error)")
            
            completion(tweet: nil, error: error)
        }
    }
    
    func createFavoriteWithTweetId(tweetId: String, params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        var _params = params ?? NSDictionary()
        _params.setValue(tweetId, forKey: "id")
        
        POST("1.1/favorites/create.json", parameters: _params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Got response from setting favorite")
            
            var tweet = Tweet(dictionary: response as! NSDictionary)
            
            completion(tweet: tweet, error: nil)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error setting favorite: \(error)")
                
                completion(tweet: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token and redirect to authorization page
        
        TwitterClient.sharedInstance().requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance().fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cheep://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            println("Got the request token")
            
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) { (error: NSError!) -> Void in
                
            println("Failed to get request token: \(error)")
            
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            println("Got the access token")
            
            TwitterClient.sharedInstance().requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance().GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                // println("Got current user: \(response)")
                
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                
                println("Got current user: \(user.name)")
                
                self.loginCompletion?(user: user, error: nil)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting current user: \(error)")
                
                self.loginCompletion?(user: nil, error: error)
            })
            
            
        
        }) { (error: NSError!) -> Void in
            
            println("Failed to receive access token: \(error)")
            
            self.loginCompletion?(user: nil, error: error)
        }
    }
}