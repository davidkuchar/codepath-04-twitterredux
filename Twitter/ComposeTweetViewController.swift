//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/24/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        navigationController?.popViewControllerAnimated(true)
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