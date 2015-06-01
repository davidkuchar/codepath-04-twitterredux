//
//  SidePanelViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/31/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

@objc enum MenuItem: Int {
    case Mentions = -1
    case Profile
    case Timeline
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
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectCell", forIndexPath: indexPath) as! SelectCell
        
        switch MenuItem(rawValue: indexPath.row) {
        case .Some(.Profile):
            cell.nameLabel.text = "Your Profile"
        case .Some(.Timeline):
            cell.nameLabel.text = "Your Timeline"
        default:
            break
        }
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch MenuItem(rawValue: indexPath.row) {
        case .Some(.Profile):
            delegate?.onMenuItemSelected?(self, menuItem: .Profile)
        case .Some(.Timeline):
            delegate?.onMenuItemSelected?(self, menuItem: .Timeline)
        default:
            break
        }
    }

    @IBAction func onTapMentions(sender: AnyObject) {
        println("onTapMentions")
        delegate?.onMenuItemSelected?(self, menuItem: .Mentions)
    }
}