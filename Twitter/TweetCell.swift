//
//  TweetCell.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTwitterHandleLabel: UILabel!
    @IBOutlet weak var timeSinceCreatedLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            if let user = tweet.user {
                userImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
                userNameLabel.text = user.name
                userTwitterHandleLabel.text = "@\(user.screenname!)"
            }
            tweetMessageLabel.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        
//        userNameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}