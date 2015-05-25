//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/25/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var retweetedImage: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTwitterHandleLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var dateTimeCreatedLabel: UILabel!
    @IBOutlet weak var numberOfRetweetsLabel: UILabel!
    @IBOutlet weak var numberOfFavoritesLabel: UILabel!
    
    @IBOutlet weak var userImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTopConstraint: NSLayoutConstraint!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if tweet != nil {
            if let retweetedByUser = tweet!.retweetedByUser {
                retweetedLabel.text = "\(retweetedByUser.name!) retweeted"
                retweetedLabel.hidden = false
                retweetedImage.hidden = false
                 userImageTopConstraint.constant = 31
                 userNameTopConstraint.constant = 37
            } else {
                retweetedLabel.hidden = true
                retweetedImage.hidden = true
                userImageTopConstraint.constant = 8
                userNameTopConstraint.constant = 14
            }
            
            if let user = tweet!.user {
                userImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
                userNameLabel.text = user.name
                if let userTwitterHandle = user.screenname {
                    userTwitterHandleLabel.text = "@\(userTwitterHandle)"
                }
            }
            
            dateTimeCreatedLabel.text =  tweet!.dateTimeCreated()
            tweetMessageLabel.text = tweet!.text
            numberOfRetweetsLabel.text = String(tweet!.retweets!)
            numberOfFavoritesLabel.text = String(tweet!.favorites!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
        println("reply!")
        
        performSegueWithIdentifier("newTweetFromDetailsSegue", sender: nil)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        println("retweet!")
        
        tweet?.retweet()
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        println("favorite!")
        
        tweet?.createFavorite()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "newTweetFromDetailsSegue" {
            if let composeTweetViewContoller = segue.destinationViewController as? ComposeTweetViewController {
                composeTweetViewContoller.replyToTweet = tweet
            }
        }
    }


}
