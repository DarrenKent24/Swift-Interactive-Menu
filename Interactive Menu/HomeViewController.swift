//
//  HomeViewController.swift
//  Interactive Menu
//
//  Created by Darren Kent on 1/11/18.
//  Copyright © 2018 Darren Kent. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var iController: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundGradient()
        createPanGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackgroundGradient(){
        
        let colorOne = UIColor(red:0/255, green:150/255, blue:150/255, alpha:1).cgColor
        let colorTwo = UIColor(red:0/255, green:150/255, blue:200/255, alpha:1).cgColor
        
        let gradientView = GradientView(customFrame: self.view.frame, primaryColor: colorOne, secondaryColor: colorTwo)
        
        self.view.insertSubview(gradientView, at: 0)
    }
    
    func createPanGesture(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: gesture.view)
        
        //* 1.2 Increases the velocity.
        let percent = ((translation.x * 1.2) / gesture.view!.bounds.size.width)
        
        let translationX = abs(translation.x)//Absolute value.
        let translationY = abs(translation.y)//Absolute value.
        
        if gesture.state == .began {
            
            iController = UIPercentDrivenInteractiveTransition()
            MenuTransitioningDelegate.menuTransitioningSingleton.interactionController = iController
            
            performSegue(withIdentifier: "MenuSegue", sender: self)
            
        } else if gesture.state == .changed {
            
            //This ends the gesture if there's too much vertical movement.
            //Set between 50 - 100.
            if translationY > 100 {
                
                gesture.isEnabled = false
                
            }else if translationX > 10 && percent < 1.0{
                
                iController?.update(percent)
            }
            
        }else if gesture.state == .ended || gesture.state == .cancelled{
            
            if percent > 0.3 {
                
                iController?.finish()
                
            }else{
                
                iController?.cancel()
            }
            
            gesture.isEnabled = true
            iController = nil
        }
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue) {
        
        //Segue identifier name: "UnwindToHomeSegue".
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MenuSegue"){
            
            let destination = segue.destination as! MenuViewController
            
            destination.transitioningDelegate = MenuTransitioningDelegate.menuTransitioningSingleton
            
            destination.modalPresentationStyle = .custom
            
            //MenuAnimation() is instantiated in the MenuTransitioningDelegate class.
            //Set it's delegate to the destination.
            MenuTransitioningDelegate.menuTransitioningSingleton.animation.delegate = destination
        }
    }

}
