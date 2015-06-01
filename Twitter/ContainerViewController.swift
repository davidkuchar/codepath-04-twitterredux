//
//  ContainerViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/31/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    
//    var storyboard = UIStoryboard(name: "Main", bundle: nil)
//    var navigationController: UINavigationController!
//    var tweetsViewController: TweetsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
//        tweetsViewController.delegate = self
//        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
//        centerNavigationController = UINavigationController(rootViewController: tweetsViewController)
        
        var navigationController = storyboard?.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        
        view.addSubview(navigationController.view)
        addChildViewController(navigationController)
        
        navigationController.didMoveToParentViewController(self)
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
