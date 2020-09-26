import MBProgressHUD

extension MBProgressHUD {
    
    var activityIndicatorColor: UIColor? {
        set {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = newValue
        }
        get {
            return UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color
        }
    }
    
    public struct HUDStyle {
        
        public struct ViewStyle {
            var style: MBProgressHUDBackgroundStyle = .solidColor
            var blurEffectStyle: UIBlurEffect.Style = .dark
            var color: UIColor = UIColor(white: 0, alpha: 0.2)
        }
        
        public let state: State
        public var labelTextColor: UIColor
        public var labelFont: UIFont?
        public var labelAlignment: NSTextAlignment
        public let mode: MBProgressHUDMode
        public var animationType: MBProgressHUDAnimation = .zoom
        public var offset: CGPoint = .zero
        public var backgroundViewStyle: ViewStyle = .init()
        public var bezelViewStyle: ViewStyle = .init(style: .blur, blurEffectStyle: .dark, color: .clear)
        public var customView: UIView?
        
        public var activityIndicatorColor: UIColor {
            if bezelViewStyle.blurEffectStyle == .dark {
                return .white
            } else {
                return .lightGray
            }
        }
        
    }
    
    public enum State {
        case toast
        case success
        case error
        case warning
        case wait
        case progress
        
        func map(_ styleClosure: ((HUDStyle) -> HUDStyle)? = nil) -> HUDStyle {
            var hudStyle: HUDStyle
            switch self {
            case .toast:
                hudStyle = .toast
            case .success:
                hudStyle = .success
            case .error:
                hudStyle = .error
            case .warning:
                hudStyle = .warning
            case .wait:
                hudStyle = .wait
            case .progress:
                hudStyle = .progress
            }
            if let _styleClosure = styleClosure {
                hudStyle = _styleClosure(hudStyle)
            }
            return hudStyle
        }
    }
    
    internal func applyHUDAppearanceStyle() {
        label.numberOfLines = 0
        areDefaultMotionEffectsEnabled = true
        removeFromSuperViewOnHide = true
    }
    
    
    /// 显示hud
    /// - Parameters:
    ///   - message: 显示hud的message ==> string
    ///   - state: hud的状态
    ///   - styleClosure: 自定义hud的样式
    open func show(_ message: String,
                   state: MBProgressHUD.State,
                   styleClosure: ((HUDStyle) -> HUDStyle)? = MVVMRExtensions.mbpStyle.defaultStyle) {
        
        __set(state: state, styleClosure: styleClosure)
        __sethide(state: state)
        label.attributedText = nil
        label.text = message
        
    }
    
    /// 显示hud
    /// - Parameters:
    ///   - message: 显示hud的message ==> NSAttributedString
    ///   - state: hud的状态
    ///   - styleClosure: 自定义hud的样式
    open func show(_ message: NSAttributedString,
                   state: MBProgressHUD.State,
                   styleClosure: ((HUDStyle) -> HUDStyle)? = MVVMRExtensions.mbpStyle.defaultStyle) {
        
        __set(state: state, styleClosure: styleClosure)
        __sethide(state: state)
        label.text = nil
        label.attributedText = message
        
    }
    
    private func __set(state: MBProgressHUD.State, styleClosure: ((HUDStyle) -> HUDStyle)? = MVVMRExtensions.mbpStyle.defaultStyle) {
        mode = .customView
        
        let hudStyle = state.map(styleClosure)
        
        bezelView.blurEffectStyle = hudStyle.bezelViewStyle.blurEffectStyle
        bezelView.style = hudStyle.bezelViewStyle.style
        bezelView.color = hudStyle.bezelViewStyle.color
        
        backgroundView.blurEffectStyle = hudStyle.backgroundViewStyle.blurEffectStyle
        backgroundView.style = hudStyle.backgroundViewStyle.style
        backgroundView.color = hudStyle.backgroundViewStyle.color
        
        activityIndicatorColor = hudStyle.activityIndicatorColor
        
        animationType = hudStyle.animationType
        offset = hudStyle.offset
        mode = hudStyle.mode
        
        let color = hudStyle.labelTextColor
        label.textColor = color
        label.font = hudStyle.labelFont
        label.textAlignment = hudStyle.labelAlignment
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    private func __sethide(state: MBProgressHUD.State) {
        show(animated: true)
        if state != .wait && state != .progress {
            hide(animated: true, afterDelay: 2)
        }
    }
}

extension MBProgressHUD.HUDStyle {
    static let error = MBProgressHUD.HUDStyle(state: .error,
                                              labelTextColor: _UIColor(255,124,124),
                                              labelFont: .systemFont(ofSize: 15, weight: .semibold),
                                              labelAlignment:.center,
                                              mode: .text)
    
    static let success = MBProgressHUD.HUDStyle(state: .success,
                                                labelTextColor: _UIColor(126,211,33),
                                                labelFont: .systemFont(ofSize: 15, weight: .regular),
                                                labelAlignment: .center,
                                                mode: .text)
    
    static let toast = MBProgressHUD.HUDStyle(state: .toast,
                                              labelTextColor: _UIColor(253,253,253),
                                              labelFont: .systemFont(ofSize: 15, weight: .regular),
                                              labelAlignment: .center,
                                              mode: .text,
                                              offset: CGPoint(x: 0, y: MBProgressMaxOffset))
    
    static let warning = MBProgressHUD.HUDStyle(state: .warning,
                                                labelTextColor: _UIColor(255,179,50),
                                                labelFont: .systemFont(ofSize: 15, weight: .medium),
                                                labelAlignment: .center,
                                                mode: .text)
    
    static let wait = MBProgressHUD.HUDStyle(state: .wait,
                                             labelTextColor: _UIColor(253,253,253),
                                             labelFont: .systemFont(ofSize: 15, weight: .regular),
                                             labelAlignment: .center,
                                             mode: .indeterminate)
    
    static let progress = MBProgressHUD.HUDStyle(state: .progress,
                                                 labelTextColor: _UIColor(253,253,253),
                                                 labelFont: .systemFont(ofSize: 15, weight: .regular),
                                                 labelAlignment: .center,
                                                 mode: .annularDeterminate)
}

private func _UIColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    return .init(red: r/255, green: g/255, blue: b/255, alpha: a)
}
