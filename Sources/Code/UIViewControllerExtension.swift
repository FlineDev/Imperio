//
//  UIViewController+Extension.swift
//  Imperio
//
//  Created by Anh Dung Pham on 15.08.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

extension UIViewController {
    class func currentViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        guard let viewController = viewController else { return nil }

        if let viewController = viewController as? UINavigationController {
            if let viewController = viewController.visibleViewController {
                return currentViewController(viewController)
            } else {
                return currentViewController(viewController.topViewController)
            }
        } else if let viewController = viewController as? UITabBarController {
            if let viewControllers = viewController.viewControllers, viewControllers.count > 5, viewController.selectedIndex >= 4 {
                return currentViewController(viewController.moreNavigationController)
            } else {
                return currentViewController(viewController.selectedViewController)
            }
        } else if let viewController = viewController.presentedViewController {
            return viewController
        } else if !viewController.childViewControllers.isEmpty {
            return viewController.childViewControllers.first!
        } else {
            return viewController
        }
    }
}
