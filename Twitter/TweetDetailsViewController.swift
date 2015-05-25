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
    
    var tweet: Tweet! {
        didSet {
            if let retweetedByUser = tweet.retweetedByUser {
                retweetedLabel.text = "\(retweetedByUser.name!) retweeted"
                retweetedLabel.hidden = false
                retweetedImage.hidden = false
//                userImageTopConstraint.constant = 31
//                userNameTopConstraint.constant = 31
//                userTwitterHandleTopConstraint.constant = 31
//                timeSinceCreatedTopConstraint.constant = 31
            } else {
                retweetedLabel.hidden = true
                retweetedImage.hidden = true
//                userImageTopConstraint.constant = 8
//                userNameTopConstraint.constant = 8
//                userTwitterHandleTopConstraint.constant = 8
//                timeSinceCreatedTopConstraint.constant = 8
            }
            
            if let user = tweet.user {
                userImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
                userNameLabel.text = user.name
                if let userTwitterHandle = user.screenname {
                    userTwitterHandleLabel.text = "@\(userTwitterHandle)"
                }
            }
            
            dateTimeCreatedLabel.text =  tweet.timeSinceCreated()
            tweetMessageLabel.text = tweet.text
            numberOfRetweetsLabel.text = String(tweet.retweets!)
            numberOfFavoritesLabel.text = String(tweet.favorites!)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
        println("reply!")
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        println("retweet!")
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        println("favorite!")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
