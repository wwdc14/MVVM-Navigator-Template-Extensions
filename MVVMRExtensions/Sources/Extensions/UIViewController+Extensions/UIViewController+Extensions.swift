import UIKit
import RxSwift
import MBProgressHUD

public protocol UIViewControllerCustomBackItemble {
    
    var disposeBag: DisposeBag { get }
    var customBackButton: UIButton { get }
    var canGoback: Bool { get }
    
    func backToPrevious()
    
}

public protocol UIViewControllerBasicMethod {
    func onec_viewWillAppear()
    func onec_viewDidAppear()
    
    func bindViewModel()
}

extension UIViewController: UIViewControllerCustomBackItemble {
    
    public var disposeBag: DisposeBag {
        let _disposeBag: DisposeBag
        if let bag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag_key) as? DisposeBag {
            _disposeBag = bag
        } else {
            let bag = DisposeBag()
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag_key, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            _disposeBag = bag
        }
        return _disposeBag
    }
    
    public var customBackButton: UIButton {
        let button: UIButton
        if let _button = objc_getAssociatedObject(self, &AssociatedKeys.customBackButton_key) as? UIButton {
            button = _button
        } else {
            button = UIButton(type: .system)
            objc_setAssociatedObject(self, &AssociatedKeys.customBackButton_key, button, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        button.addTarget(self, action: #selector(_backToPrevious), for: .touchUpInside)
        return button
    }
    
    @objc open func backToPrevious() {
        if let navigationController = self.navigationController, canGoback {
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc open var canGoback: Bool {
        return true
    }
    
    internal var is_onec_viewWillAppear: Bool {
        get { (objc_getAssociatedObject(self, &AssociatedKeys.onecWillAppear_key) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.onecWillAppear_key, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    internal var is_onec_viewDidAppear: Bool {
        get { (objc_getAssociatedObject(self, &AssociatedKeys.onecDidAppear_key) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.onecDidAppear_key, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    @objc fileprivate func _backToPrevious() {
        backToPrevious()
    }
}

extension UIViewController: UIViewControllerBasicMethod {
    
    @objc open func onec_viewWillAppear() {}
    
    @objc open func onec_viewDidAppear() {}
    
    @objc open func bindViewModel() {}
    
}

extension UIViewController {
    private struct AssociatedKeys {
        static var disposeBag_key = "com.hy.disposeBag.key"
        static var customBackButton_key = "com.hy.customBackButton.key"
        static var onecDidAppear_key = "com.hy.firstDidAppear.key"
        static var onecWillAppear_key = "com.hy.onecWillAppear.key"
    }
    
    internal static func work() {
        
        let originalSelector0 = #selector(viewDidLoad)
        let swizzledSelector0 = #selector(custom_viewDidLoad)
        swizzle(originalSelector: originalSelector0, swizzledSelector: swizzledSelector0)
        
        let originalSelector1 = #selector(viewWillAppear(_:))
        let swizzledSelector1 = #selector(custom_viewWillAppear(_:))
        swizzle(originalSelector: originalSelector1, swizzledSelector: swizzledSelector1)
        
        let originalSelector2 = #selector(viewDidAppear(_:))
        let swizzledSelector2 = #selector(custom_viewDidAppear(_:))
        swizzle(originalSelector: originalSelector2, swizzledSelector: swizzledSelector2)
        
        let originalSelector3 = #selector(viewWillDisappear(_:))
        let swizzledSelector3 = #selector(custom_viewWillDisappear(_:))
        swizzle(originalSelector: originalSelector3, swizzledSelector: swizzledSelector3)
        
    }
    
    private static func swizzle(originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
    
    private var hasInApp: Bool {
        let CFBundleExecutable = Bundle.main.infoDictionary!["CFBundleExecutable"] ?? "OoAa"
        return String(describing: self).contains("\(CFBundleExecutable).")
    }
    
    @objc private func custom_viewDidLoad() {
        custom_viewDidLoad()
        guard hasInApp else { return }
        bindViewModel()
        setBackButtonItem()
    }
    
    @objc private func custom_viewWillAppear(_ anim: Bool) {
        custom_viewWillAppear(anim)
        guard hasInApp else { return }
        if !is_onec_viewWillAppear {
            onec_viewWillAppear()
            is_onec_viewWillAppear = true
        }
    }
    
    @objc private func custom_viewDidAppear(_ anim: Bool) {
        custom_viewDidAppear(anim)
        guard hasInApp else { return }
        if !is_onec_viewDidAppear {
            onec_viewDidAppear()
            is_onec_viewDidAppear = true
        }
    }
    
    @objc private func custom_viewWillDisappear(_ anim: Bool) {
        custom_viewWillDisappear(anim)
        guard hasInApp else { return }
    }
    
    private func setBackButtonItem() {
        if let viewControllers = navigationController?.viewControllers, viewControllers.count > 1 {
            customBackButton.setImage(MVVMNavigatorExtensions.navigation.backImage, for: UIControl.State())
            if MVVMNavigatorExtensions.navigation.backTitle.isEmpty {
                customBackButton.setTitle("   ", for: .normal)
            } else {
                customBackButton.setTitle(MVVMNavigatorExtensions.navigation.backTitle, for: UIControl.State())
            }
            customBackButton.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
            customBackButton.imageView?.contentMode = .scaleAspectFit
            let leftBarBtn = UIBarButtonItem(customView: customBackButton)
            navigationItem.leftBarButtonItems = [leftBarBtn]
        }
    }
    
}

extension UIViewController {
    public var hud: MBProgressHUD {
        let _mbpro: MBProgressHUD
        if let mbpro = MBProgressHUD.forView(view) {
            _mbpro = mbpro
        } else {
            _mbpro = MBProgressHUD(view: view)
            view.addSubview(_mbpro)
            _mbpro.applyHUDAppearanceStyle()
        }
        return _mbpro
    }
}

