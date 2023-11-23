//
//  UIWindow+RootViewController.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit

extension UIWindow {
    func setRootViewController(_ newRootViewController: UIViewController, transition: CATransition? = nil) {
        let previousViewController = rootViewController

        if let transition = transition {
            layer.add(transition, forKey: kCATransition)
        }

        rootViewController = newRootViewController

        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            })
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }

        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
