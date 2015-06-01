//
//  TweetCell.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
    optional func onReplyFromTweetCell(tweetCell: TweetCell)
    optional func onOpenProfileFromTweetCell(tweetCell: TweetCell)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeSinceCreatedLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var userImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTopConstraint: NSLayoutConstraint!
    
    weak var delegate: TweetCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            if let retweetedByUser = tweet.retweetedByUser {
                retweetImage.hidden = false
                retweetedLabel.hidden = false
                retweetedLabel.text = "\(retweetedByUser.name!) retweeted"
                userImageTopConstraint.constant = 31
                userNameTopConstraint.constant = 31
            } else {
                retweetImage.hidden = true
                retweetedLabel.hidden = true
                userImageTopConstraint.constant = 8
                userNameTopConstraint.constant = 8
            }
            
            if let user = tweet.user {
                userImageButton.setBackgroundImageForState(.Normal, withURL: NSURL(string: user.profileImageUrl!))
                userNameLabel.text = user.name
                if let userTwitterHandle = user.screenname {
                    usernameButton.setTitle("@\(userTwitterHandle)", forState: UIControlState.Normal)
                }
            }
            
            timeSinceCreatedLabel.text =  tweet.timeSinceCreated()
            tweetMessageLabel.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageButton.layer.cornerRadius = 3
        userImageButton.clipsToBounds = true
        
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
    
    @IBAction func onOpenProfileFromUserImage(sender: AnyObject) {
        delegate?.onOpenProfileFromTweetCell?(self)
    }
    
    @IBAction func onOpenProfileFromUserName(sender: AnyObject) {
        delegate?.onOpenProfileFromTweetCell?(self)
    }

    @IBAction func onReply(sender: AnyObject) {
        println("reply!")
                
        delegate?.onReplyFromTweetCell?(self)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        println("retweet!")
        
        tweet?.retweet()
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        println("favorite!")
        
        tweet?.createFavorite()
    }
}