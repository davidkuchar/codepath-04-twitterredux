//
//  ViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/18/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance().requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance().fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in

                println("Got the request token")
            
            }) { (error: NSError!) -> Void in
            
                println("Failed to get request token: \(error)")
        }
    }
}

