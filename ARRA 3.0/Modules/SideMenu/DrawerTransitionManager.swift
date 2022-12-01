//
//  DrawerTransitionManager.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import Foundation
import UIKit

class DrawerTransitionManager:NSObject,UIViewControllerTransitioningDelegate{
    let slideAnimation = DrawerSlideAnimation()
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = true
           return slideAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimation.isPresenting = false
            return slideAnimation 
    }
 
}
