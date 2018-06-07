//
//  MACirculerReveal.swift
//  MACircularReveal
//
//  Created by Marwan on 12/2/17.
//  Copyright © 2017 Marwan. All rights reserved.
//

import UIKit

class MACirculerReveal {
    
    typealias AnimationCompletion = (_ animation: CAAnimation) -> Void
    
    // circular reveals the child view on parent view from the from view with duration and fires an optional completion handler when animation completes
    static func circularReveal(_ child: UIView, on parent: UIView, from: UIView, with duration: CFTimeInterval = 0.3, completion: AnimationCompletion?) {
        
        // add child to parent
        parent.addSubview(child)
        
        // create the initial and final mask paths
        let circleMaskPathInitial = UIBezierPath(ovalIn: from.frame)
        let extremePoint = CGPoint(x: from.center.x + 100, y: from.center.y - parent.bounds.height)
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: from.frame.insetBy(dx: -radius, dy: -radius))
        
        // set the final mask to child to avoid jerking
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        child.layer.mask = maskLayer
        
        // create animation for the mask
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = duration
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
        // fire completion handler after duration
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(duration * 1000))) {
            completion?(maskLayerAnimation)
        }
    }
    
    // circular unreveals the child view from parent view to the to view with duration and fires an optional completion handler when animation completes
    static func circularUnReveal(_ child: UIView, from parent: UIView, to: UIView, with duration: CFTimeInterval = 0.3, completion: AnimationCompletion?) {
        
        // create the initial and final mask paths
        let circleMaskPathFinal = UIBezierPath(ovalIn: to.frame)
        let extremePoint = CGPoint(x: to.center.x + 100, y: to.center.y - parent.bounds.height)
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathInitial = UIBezierPath(ovalIn: to.frame.insetBy(dx: -radius, dy: -radius))
        
        // set the final mask to child to avoid jerking
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        child.layer.mask = maskLayer
        
        // create animation for the mask
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = duration
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
        // remove the child from parent after the duration
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(duration * 1000))) {
            child.removeFromSuperview()
            
            // fire completion handler
            completion?(maskLayerAnimation)
        }
    }
    
}
