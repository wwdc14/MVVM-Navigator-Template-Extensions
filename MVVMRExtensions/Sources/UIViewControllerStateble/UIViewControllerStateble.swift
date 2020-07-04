import SnapKit
import SwiftyGif
import UIKit.UIView
import UIKit.UIViewController
import UIKit.UIActivityIndicatorView

public protocol StateType {
    
    typealias Action = () -> Void
    
    var title: String?          { set get }
    
    var description: String?    { set get }
    
    var actionTitle: String?    { set get }
    
    var image: UIImage?         { set get }
    
    var visibleActivityIndicator: Bool { set get }
    
    var activityIndicatorAxis: NSLayoutConstraint.Axis { set get }
    
    var state: UIViewController.State { get }
    
    var action: Action?   { get }
    
}

extension StateType {
        var title: String? {
//            if case .loading = state {
//
//            } else if case .success = state {
//
//            } else if case .failure(let error) = state {
//
//            }
            return ""
        }
        
        var description: String? {
            if case .failure(let error) = state {
                return error.localizedDescription
            }
            return ""
        }
        
        var actionTitle: String? {
    //        if case .loading = state {
    //
    //        } else if case .success = state {
    //
    //        } else if case .failure(let error) = state {
    //
    //        }
            return ""
        }
        
        var image: UIImage? {
            return nil
        }
}

public protocol StateViewType where Self: UIView {
    
    var model: StateType { get }
    
    func onUpdate(_ model: StateType)
    
}

public protocol UIViewControllerStateble {
    
//    typealias StateContext = (state: State, )
    
    var stateView: StateViewType { get }
    
    func onState(_ state: StateType)
    
}

extension UIViewController: UIViewControllerStateble {
    
    private static let StateViewTag = 9765
    
    public var stateView: StateViewType {
        get {
            
            if let stateView = view.viewWithTag(UIViewController.StateViewTag) as? StateViewType {
                view.bringSubviewToFront(stateView)
                return stateView
            } else {
                let stateView = StateView(model: StateModel.none)
                stateView.tag = UIViewController.StateViewTag
                stateView.alpha = 0
                stateView.isHidden = true
                view.addSubview(stateView)
                stateView.snp.makeConstraints{$0.edges.equalToSuperview()}
                return stateView
            }
        }
        set {
            view.viewWithTag(UIViewController.StateViewTag)?.removeFromSuperview()
            newValue.tag = UIViewController.StateViewTag
            view.addSubview(view)
            stateView.snp.makeConstraints{$0.edges.equalToSuperview()}
        }
    }
    
    public func onState(_ state: StateType) {
        if self.stateView.alpha == 0 {
            self.stateView.isHidden = false
        }
        UIView.transition(with: stateView, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.stateView.onUpdate(state)
        }, completion: { _ in
            if self.stateView.alpha == 0 {
                self.stateView.isHidden = true
            }
        })
    }
    
}

extension UIViewController {
    
    public enum State {
        case none
        case loading
        case success
        case failure(_ error: Error)
    }
    
    public struct StateModel: StateType {
        
        public var title: String?
        
        public var description: String?
        
        public var actionTitle: String?

        public var image: UIImage?
        
        public var state: UIViewController.State
        
        public var action: Action?
        
        public var visibleActivityIndicator: Bool = true
        
        public var activityIndicatorAxis: NSLayoutConstraint.Axis = .vertical
        
        public static let none = StateModel(.none)
        
        public static let loading = StateModel(.loading)
        
        public static let success = StateModel(.success)
        
        public static func failure(_ error: Error, action: Action?) -> Self {
            return StateModel(.failure(error), action: action)
        }
        
        public static func loading(_ title: String? = nil,
                                   description: String? = nil,
                                   actionTitle: String? = nil,
                                   image: UIImage? = nil) -> Self {
            var loading = StateModel(.loading)
            loading.title = title
            loading.description = description
            loading.actionTitle = actionTitle
            loading.image = image
            loading.activityIndicatorAxis = .horizontal
            return loading
        }
        
        private init(_ state: State, action: Action? = nil) {
            self.state = state
            self.action = action
        }
        
    }
    
    public class StateView: UIView, StateViewType {
        
        public var model: StateType
        
        public let titleLabel: UILabel = {
            $0.font = UIFont.preferredFont(forTextStyle: .headline)
            $0.textColor = UIColor.black
            $0.textAlignment = .center
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
            return $0
        }(UILabel())
        
        public let descriptionLabel: UILabel = {
            $0.font = UIFont.preferredFont(forTextStyle: .caption2)
            $0.textColor = UIColor.black
            $0.textAlignment = .center
            $0.numberOfLines = 0
            
            return $0
        }(UILabel())
        
        #if swift(>=4.2)
        public let hActivityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            #if os(tvOS)
            $0.style = .whiteLarge
            #endif
            #if os(iOS)
            $0.style = .gray
            #endif
            return $0
        }(UIActivityIndicatorView(style: .whiteLarge))
        public let vActivityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            #if os(tvOS)
            $0.style = .whiteLarge
            #endif
            #if os(iOS)
            $0.style = .gray
            #endif
            return $0
        }(UIActivityIndicatorView(style: .whiteLarge))
        #else
        public let hActivityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            #if os(tvOS)
                $0.activityIndicatorViewStyle = .whiteLarge
            #endif
            
            #if os(iOS)
                $0.activityIndicatorViewStyle = .gray
            #endif
            return $0
        }(UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge))
        public let vActivityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            #if os(tvOS)
                $0.activityIndicatorViewStyle = .whiteLarge
            #endif
            
            #if os(iOS)
                $0.activityIndicatorViewStyle = .gray
            #endif
            return $0
        }(UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge))
        #endif
        
        public let imageView: UIImageView = {
            $0.contentMode = .center
            
            return $0
        }(UIImageView())
        
        public let actionButton: UIButton = {
            
            return $0
        }(UIButton(type: .system))
        
        public let verticalStackView: UIStackView = {
            $0.axis = .vertical
            $0.spacing = 10
            $0.alignment = .center

            return $0
        }(UIStackView())
        
        public let horizontalStackView: UIStackView = {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
            $0.distribution = .equalSpacing
            return $0
        }(UIStackView())
        
        init(model: StateType) {
            
            self.model = model
            super.init(frame: .zero)
            
            let titleStackView = UIStackView()
            titleStackView.addArrangedSubview(hActivityIndicatorView)
            titleStackView.addArrangedSubview(titleLabel)
            titleStackView.distribution = .equalSpacing
            titleStackView.alignment = .fill
            titleStackView.axis = .horizontal
            titleStackView.spacing = 5
            
            actionButton.addTarget(self, action: #selector(actionButtonAction), for: .touchUpInside)
            
            addSubview(horizontalStackView)
            horizontalStackView.addArrangedSubview(hActivityIndicatorView)
            horizontalStackView.addArrangedSubview(verticalStackView)
            
            verticalStackView.addArrangedSubview(imageView)
            verticalStackView.addArrangedSubview(vActivityIndicatorView)
            verticalStackView.addArrangedSubview(titleStackView)
            verticalStackView.addArrangedSubview(descriptionLabel)
            verticalStackView.addArrangedSubview(actionButton)
            
            horizontalStackView.snp.makeConstraints{
                $0.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.width.lessThanOrEqualTo(UIScreen.main.bounds.width - 40)
            }
//            imageView.snp.makeConstraints { make in
//                make.width.greaterThanOrEqualTo(UIScreen.main.bounds.width - 40)
//            }
            
            backgroundColor = .white
            
        }
        
        open override var tintColor: UIColor! {
            didSet {
                titleLabel.textColor = tintColor
                descriptionLabel.textColor = tintColor
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func actionButtonAction() {
            model.action?()
        }
        
        public func onUpdate(_ model: StateType) {
            self.model = model
            imageView.stopAnimatingGif()
            if let image = model.image, image.imageData != nil {
                imageView.setGifImage(image, manager: .defaultManager, loopCount: -1)
                imageView.startAnimatingGif()
            } else if let image = model.image {
                imageView.gifImage = nil
                imageView.image = image
            } else {
                imageView.image = nil
                imageView.gifImage = nil
            }
            titleLabel.text = model.title
            descriptionLabel.text = model.description
            actionButton.setTitle(model.actionTitle, for: UIControl.State())
            
            if case .loading = model.state {
                
                hActivityIndicatorView.startAnimating()
                vActivityIndicatorView.startAnimating()
                vActivityIndicatorView.isHidden = true
                hActivityIndicatorView.isHidden = true
                if model.activityIndicatorAxis == .horizontal {
                    vActivityIndicatorView.isHidden = true
                } else if model.activityIndicatorAxis == .vertical {
                    hActivityIndicatorView.isHidden = true
                }
                alpha = 1
                
            } else if case .success = model.state {
                
                hActivityIndicatorView.stopAnimating()
                vActivityIndicatorView.stopAnimating()
                alpha = 0
                
            } else if case .failure = model.state {
               
                hActivityIndicatorView.stopAnimating()
                vActivityIndicatorView.stopAnimating()
                alpha = 1
                
            } else {
                /// `none`
                hActivityIndicatorView.stopAnimating()
                vActivityIndicatorView.stopAnimating()
                alpha = 0
            }
            
            imageView.isHidden = imageView.image == nil
            titleLabel.isHidden = titleLabel.text == nil
            descriptionLabel.isHidden = descriptionLabel.text == nil
            actionButton.isHidden = model.action == nil
            
            verticalStackView.isHidden = imageView.isHidden && descriptionLabel.isHidden && actionButton.isHidden && titleLabel.isHidden
            
        }
        
    }
    
}
