//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var tweetMessageTextView: UITextView!
    
    var replyToTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userImageButton.setImageForState(.Normal, withURL: NSURL(string: User.currentUser!.profileImageUrl!))
        userImageButton.layer.cornerRadius = 3
        userImageButton.clipsToBounds = true
        userNameLabel.text = User.currentUser!.name
        if let userTwitterHandle = User.currentUser!.screenname {
            usernameButton.setTitle("@\(userTwitterHandle)", forState: UIControlState.Normal)
        }
        
        if let replyToTwitterHandle = replyToTweet?.user?.screenname {
            tweetMessageTextView.text = "@\(replyToTwitterHandle) "
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onTweet(sender: AnyObject) {
        // send the tweet first!
        
        println(tweetMessageTextView.text)
        
        Tweet.sendTweet(tweetMessageTextView.text)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "onOpenProfile" {
            if let profileViewContoller = segue.destinationViewController as? ProfileViewController {
                profileViewContoller.user = User.currentUser!
            }
        }
    }
}
