import UIKit

public struct MVVMRExtensions {
    
    public static var navigation = Navigation.self
    
    public static func works() {
        UIViewController.work()
    }
}

extension MVVMRExtensions {
    public struct Navigation {
        public static var backTitle: String = ""
        public static var backImage: UIImage? = nil
    }
}
