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
    
    var tweet: Tweet! {
        didSet {
            
            userImage.setImageWithURL(NSURL(string: tweet.user?.profileImageUrl ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
//
//
//@IBOutlet weak var thumbImageView: UIImageView!
//@IBOutlet weak var nameLabel: UILabel!
//@IBOutlet weak var distanceLabel: UILabel!
//@IBOutlet weak var ratingImageLabel: UIImageView!
//@IBOutlet weak var reviewsCountLabel: UILabel!
//@IBOutlet weak var priceLabel: UILabel!
//@IBOutlet weak var locationLabel: UILabel!
//@IBOutlet weak var categoriesLabel: UILabel!
//
//var business: Business! {
//didSet {
//    nameLabel.text = business.name
//    thumbImageView.setImageWithURL(business.imageURL)
//    categoriesLabel.text = business.categories
//    locationLabel.text = business.address
//    reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
//    ratingImageLabel.setImageWithURL(business.ratingImageURL)
//    distanceLabel.text = business.distance
//}
//}
//
//override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//    
//    thumbImageView.layer.cornerRadius = 3
//    thumbImageView.clipsToBounds = true
//    
//    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
//}
//
//override func layoutSubviews() {
//    super.layoutSubviews()
//    
//    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
//}
//
