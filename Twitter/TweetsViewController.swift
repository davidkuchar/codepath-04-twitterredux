//
//  TweetsViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    func loadTweets() {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
        
        TwitterClient.sharedInstance().homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            
            self.refreshControl?.endRefreshing()
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        })
    }
    
    func refreshTweets(sender:AnyObject)
    {
        // Code to refresh table view
        loadTweets()
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refreshTweets:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets?[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        self.performSegueWithIdentifier("tweetDetailSegue", sender: indexPath)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func onReplyFromTweetCell(tweetCell: TweetCell) {
        let indexPath = tableView.indexPathForCell(tweetCell)!
        
        performSegueWithIdentifier("newTweetSegue", sender: indexPath)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "tweetDetailSegue" {
            let indexPath = sender as! NSIndexPath

            if let tweetDetailsViewContoller = segue.destinationViewController as? TweetDetailsViewController {
                tweetDetailsViewContoller.tweet = tweets![indexPath.row]
            }
        } else if segue.identifier == "newTweetSegue" {
            let indexPath = sender as! NSIndexPath
            
            if let composeTweetViewContoller = segue.destinationViewController as? ComposeTweetViewController {
                composeTweetViewContoller.replyToTweet = tweets![indexPath.row]
            }
        }
    }
}
