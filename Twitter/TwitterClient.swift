//
//  TwitterClient.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TwitterClient: BDBOAuth1RequestOperationManager {
   
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
//        
//        println("TwitterConsumerKey \(Static.twitterConsumerKey)")
//        println("TwitterConsumerSecret \(Static.twitterConsumerSecret)")
        
        return Static.instance
    }
}