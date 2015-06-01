//
//  ProfileViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/31/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var userBackgroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTwitterHandleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if user!.headerImageUrl != nil {
            userBackgroundImage.setImageWithURL(NSURL(string: user!.headerImageUrl!))
        }
        userImage.setImageWithURL(NSURL(string: user!.profileImageUrl!))
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        userNameLabel.text = user!.name
        userTwitterHandleLabel.text = "@\(user!.screenname!)"
        tweetCountLabel.text = String(user!.tweetCount!)
        followingCountLabel.text = String(user!.followingCount!)
        followerCountLabel.text = String(user!.followerCount!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
