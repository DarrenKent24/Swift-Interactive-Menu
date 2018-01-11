//
//  GradientView.swift
//  Interactive Menu
//
//  Created by Darren Kent on 1/11/18.
//  Copyright © 2018 Darren Kent. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var colorOne:CGColor = UIColor.clear.cgColor
    var colorTwo:CGColor = UIColor.clear.cgColor
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    convenience init(customFrame:CGRect, primaryColor:CGColor, secondaryColor:CGColor){
        
        self.init(frame: customFrame)
        
        self.colorOne = primaryColor
        self.colorTwo = secondaryColor
        
        setupViewLayerAsGradientLayer()
    }
    
    override public class var layerClass: AnyClass{
        
        get{
            return CAGradientLayer.self
        }
    }
    
    func setupViewLayerAsGradientLayer(){
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let gradient:CAGradientLayer = self.layer as! CAGradientLayer
        
        gradient.colors = [colorOne, colorTwo]
        gradient.startPoint = CGPoint(x: 0.5,y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5,y: 1.0)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
