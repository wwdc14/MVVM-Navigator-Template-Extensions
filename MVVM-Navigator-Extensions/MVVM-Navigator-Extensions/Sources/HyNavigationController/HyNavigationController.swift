//
//  HyNavigationController.swift
//  MVVM-Navigator-Extensions
//
//  Created by Hy on 2020/6/22.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit

class HyNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if viewControllers.count < 2 || visibleViewController == viewControllers[0] {
                return false
            }
        }
        return visibleViewController?.canGoback ?? true
    }
    
}
