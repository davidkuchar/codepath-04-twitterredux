//
//  TwitterClient.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit


class TwitterClient: BDBOAuth1RequestOperationManager {
   
    class var sharedInstance: TwitterClient {

        let twitterBaseURLString = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterBaseURL")
        let twitterConsumerKey = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterConsumerKey")
        let twitterConsumerSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("TwitterConsumerSecret")
        
        let twitterBaseURL = NSURL(string: twitterBaseURLString)
        
        return TwitterClient(
            baseURL: twitterBaseURL,
            consumerKey: twitterConsumerKey,
            consumerSecret: twitterConsumerSecret
        )
    }
    
}
