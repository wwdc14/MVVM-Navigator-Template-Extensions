import UIKit

public struct MVVMNavigatorExtensions {
    
    public static var navigation = Navigation.self
    
    public static func works() {
        UIViewController.work()
    }
}

extension MVVMNavigatorExtensions {
    public struct Navigation {
        public static var backTitle: String = ""
        public static var backImage: UIImage? = nil
    }
}
