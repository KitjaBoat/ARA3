//
//  DrawerPresentationController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class DrawerPresentationController: UIPresentationController {
  
    @objc private func dismissPresentedController() {
        presentedViewController.dismiss(animated: true)
    }
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedController))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.8, height: parentSize.height)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        guard let containerView = containerView else {
            return frame
        }
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        return frame
    }
    
    override func containerViewWillLayoutSubviews() {
            presentedView?.frame = frameOfPresentedViewInContainerView
        }
    
    override func presentationTransitionWillBegin() {
        guard  let containerView = containerView else {
            return
        }
    // before presentation
    // add dimmingView to container view beneath presentedController
        containerView.insertSubview(dimmingView, at: 0)
    // set constraints of dimming view to fit container
    // that's why we set translatesAutoresizingMaskIntoConstraints to false
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    // check for animation coordinator
    // if it's missing make dimming view visible immediately
       guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }
    // otherwise do it in animation
    // duration of this animation same as duration of slide animation
       coordinator.animate { (_) in
            self.dimmingView.alpha = 1
        }
    }
    override func dismissalTransitionWillBegin() {
    // do the same for making dimming view transparent on dismiss
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
            return
        }
     
        coordinator.animate { (_) in
            self.dimmingView.alpha = 0
        }
    }
    
    
}
