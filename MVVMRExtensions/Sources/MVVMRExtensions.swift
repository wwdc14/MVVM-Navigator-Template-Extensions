import UIKit
import MBProgressHUD

public struct MVVMRExtensions {
    
    public static var navigation = Navigation.self
    public static var mbpStyle = MBPStyle.self
    public static var mbpConfiguration = MBPConfiguration.self
    
    public static func works() {
        UIViewController.work()
    }
}

extension MVVMRExtensions {
    public struct Navigation {
        public static var backTitle: String = ""
        public static var backImage: UIImage? = nil
    }
    public struct MBPStyle {
        public static var defaultStyle: ((MBProgressHUD.HUDStyle) -> MBProgressHUD.HUDStyle) = { style in
            return style
        }
    }
    public struct MBPConfiguration {
        public static var hideDelay: TimeInterval = 1
    }
}
