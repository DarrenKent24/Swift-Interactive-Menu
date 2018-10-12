//
//  MenuAnimatedTransitioning.swift
//  Interactive Menu
//
//  Created by Darren Kent on 1/11/18.
//  Copyright © 2018 Darren Kent. All rights reserved.
//

import UIKit

protocol MenuAnimationDelegate{
    
    func handleTapProtocol(_ gesture: UITapGestureRecognizer)
    func handlePanProtocol(_ gesture: UIPanGestureRecognizer)
}

class MenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    var duration:Double = 0.4
    var delegate:MenuAnimationDelegate?
    
    var snapshotView:UIView?{
        didSet{
            
            if delegate != nil{
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                snapshotView?.addGestureRecognizer(tapGesture)
                
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                snapshotView?.addGestureRecognizer(panGesture)
            }
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        
        if delegate != nil{
            
            delegate?.handleTapProtocol(gesture)
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer){
        
        if delegate != nil{
            
            delegate?.handlePanProtocol(gesture)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView   = transitionContext.containerView
        let toView = transitionContext.viewController(forKey: .to)!.view!
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        
        let centerX = containerView.center.x
        let centerY = containerView.center.y
        
        let offCenterLeftX = centerX - 40
        let offCenterRightX = centerX + 225
        
        let offCenterRight:CGPoint = CGPoint(x: offCenterRightX, y: centerY)
        let offScreenLeft:CGPoint = CGPoint(x: offCenterLeftX, y: centerY)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        if isPresenting == true {
            
            toView.center = offScreenLeft
            containerView.addSubview(toView)
            
            snapshotView = fromView.snapshotView(afterScreenUpdates: false)!
            snapshotView?.layer.shadowOpacity = 0.8
            snapshotView?.layer.shadowRadius = 4.0
            snapshotView?.layer.shadowColor = UIColor.black.cgColor
            snapshotView?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            
            containerView.addSubview(snapshotView!)
            
            UIView.animate(withDuration: duration, animations: {
                
                self.snapshotView?.center = offCenterRight
                toView.center = containerView.center
                
            }, completion: { _ in
                
                if transitionContext.transitionWasCancelled{
                    
                    transitionContext.completeTransition(false)
                    
                }else{
                    
                    transitionContext.completeTransition(true)
                }
            })
            
        } else {
            
            UIView.animate(withDuration: duration, animations: {
                
                self.snapshotView?.center = containerView.center
                fromView.center = offScreenLeft
                
            }, completion: { _ in
                
                if transitionContext.transitionWasCancelled{
                    
                    transitionContext.completeTransition(false)
                    
                }else{
                    
                    transitionContext.completeTransition(true)
                    self.snapshotView?.removeFromSuperview()
                }
            })
        }
    }

}
