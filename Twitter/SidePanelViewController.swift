//
//  SidePanelViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/31/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

@objc enum MenuItem: Int {
    case Profile = 1
    case Timeline
    case Mentions
}

@objc protocol SidePanelViewControllerDelegate {
    optional func onMenuItemSelected(sender: AnyObject?, menuItem: MenuItem)
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SidePanelViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath) as! UITableViewCell
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    @IBAction func onTapMentions(sender: AnyObject) {
        println("onTapMentions")
        delegate?.onMenuItemSelected?(self, menuItem: MenuItem.Mentions)
    }
}