//
//  CharacterAnimationController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

enum CharacterAnimationType {
    case fadeIn, fadeOut
}

class CharacterAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var type: CharacterAnimationType
    
    init(type: CharacterAnimationType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        
        let duration = transitionDuration(using: transitionContext)
        
        switch type {
        case .fadeIn:
            let containerView = transitionContext.containerView
            
            containerView.addSubview(toVC.view)
            toVC.view.alpha = 0
            
            UIView.animate(withDuration: duration, animations: {
                containerView.setNeedsLayout()
                toVC.view.alpha = 1
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .fadeOut:
            let containerView = transitionContext.containerView
            
            containerView.addSubview(toVC.view)
            containerView.bringSubviewToFront(fromVC.view)
            
            UIView.animate(withDuration: duration, animations: {
                containerView.setNeedsLayout()
                fromVC.view.alpha = 0
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
        
    }
}
