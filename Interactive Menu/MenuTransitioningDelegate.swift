//
//  MenuTransitioningDelegate.swift
//  Interactive Menu
//
//  Created by Darren Kent on 1/11/18.
//  Copyright © 2018 Darren Kent. All rights reserved.
//

import UIKit

class MenuTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    static let menuTransitioningSingleton = MenuTransitioningDelegate()
    
    private override init() {}
    
    var animation = MenuAnimatedTransitioning()
    
    weak var interactionController: UIPercentDrivenInteractiveTransition?
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animation.isPresenting = true
        
        return animation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animation.isPresenting = false
        
        return animation
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return MenuPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
