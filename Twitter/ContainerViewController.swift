//
//  ContainerViewController.swift
//  Twitter
//
//  Created by David Kuchar on 5/31/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

enum SlideOutState {
    case Collapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController, SidePanelViewControllerDelegate {

    var centerNavigationController: UINavigationController!
    var currentState: SlideOutState = .Collapsed
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!

    var panOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        centerNavigationController = storyboard?.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(sender: AnyObject) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            panOriginalCenter = point
            showShadowForCenterViewController(true)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            var translation_x = point.x - panOriginalCenter.x
            if translation_x >= 0  {
                centerNavigationController.view.frame.origin.x = translation_x
            }
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                openLeftPanel()
            } else {
                closeLeftPanel()
            }
        }
    }
    
    func openLeftPanel() {
        if currentState != .LeftPanelExpanded {
            addLeftPanelViewController()
            animateLeftPanel(shouldExpand: true)
        }
    }
    
    func closeLeftPanel() {
        if currentState == .LeftPanelExpanded {
            animateLeftPanel(shouldExpand: false)
        } else if centerNavigationController.view.frame.origin.x > 0 {
            centerNavigationController.view.frame.origin.x = 0
        }
        showShadowForCenterViewController(false)
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = storyboard?.instantiateViewControllerWithIdentifier("LeftPanelViewController") as? SidePanelViewController
            leftViewController?.delegate = self
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .Collapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func onMenuItemSelected(sender: AnyObject?, menuItem: MenuItem) {
        switch menuItem {
        case .Profile:
            centerNavigationController.popToRootViewControllerAnimated(false)
            centerNavigationController.topViewController.performSegueWithIdentifier("onOpenProfile", sender: sender)
            closeLeftPanel()
        case .Timeline:
            centerNavigationController.popToRootViewControllerAnimated(true)
            closeLeftPanel()
        case .Mentions:
            centerNavigationController.popToRootViewControllerAnimated(false)
            centerNavigationController.topViewController.performSegueWithIdentifier("onOpenMentions", sender: sender)
            closeLeftPanel()
        default:
            println("opened menuitem default")
        }
    }

}