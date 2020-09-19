import UIKit

open class FixInteractiveNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if viewControllers.count < 2 || visibleViewController == viewControllers[0] {
                return false
            }
        }
        return visibleViewController?.navigationShouldPopOnBackButton ?? true
    }
    
}
