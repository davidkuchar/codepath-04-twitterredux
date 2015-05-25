//
//  TweetCell.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTwitterHandleLabel: UILabel!
    @IBOutlet weak var timeSinceCreatedLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    
    @IBOutlet weak var userImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userTwitterHandleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeSinceCreatedTopConstraint: NSLayoutConstraint!
    
    var formatter = NSDateFormatter()
    
    var tweet: Tweet! {
        didSet {
            if let retweetedByUser = tweet.retweetedByUser {
                retweetedLabel.text = "\(retweetedByUser.name!) retweeted"
                retweetedLabel.hidden = false
                userImageTopConstraint.constant = 31
                userNameTopConstraint.constant = 31
                userTwitterHandleTopConstraint.constant = 31
                timeSinceCreatedTopConstraint.constant = 31
            } else {
                retweetedLabel.hidden = true
                userImageTopConstraint.constant = 8
                userNameTopConstraint.constant = 8
                userTwitterHandleTopConstraint.constant = 8
                timeSinceCreatedTopConstraint.constant = 8
            }
            
            if let user = tweet.user {
                userImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
                userNameLabel.text = user.name
                if let userTwitterHandle = user.screenname {
                    userTwitterHandleLabel.text = "@\(userTwitterHandle)"
                }
            }
            
//
//            hoursFrom(
//            
//            tweet.createdAt
//            
//            timeSinceCreatedLabel.text = tweet.createdAt
            tweetMessageLabel.text = tweet.text
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        
//        tweetMessageLabel.preferredMaxLayoutWidth = tweetMessageLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        tweetMessageLabel.preferredMaxLayoutWidth = tweetMessageLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}