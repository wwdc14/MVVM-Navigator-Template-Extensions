import UIKit.UIView
import UIKit.UIViewController
import UIKit.UIActivityIndicatorView

public protocol StateType {
    
    typealias Action = () -> Void
    
    var title: String?          { set get }
    
    var description: String?    { set get }
    
    var actionTitle: String?    { set get }
    
    var image: UIImage?         { set get }
    
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
                stateView.isHidden = true
                view.addSubview(stateView)
                stateView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    stateView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
                    stateView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
                    stateView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
                    stateView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
                ])
                return stateView
            }
        }
        set {
            view.viewWithTag(UIViewController.StateViewTag)?.removeFromSuperview()
            newValue.tag = UIViewController.StateViewTag
            view.addSubview(view)
            newValue.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newValue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                newValue.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                newValue.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
                newValue.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
                newValue.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
                newValue.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
            ])
        }
    }
    
    public func onState(_ state: StateType) {
        stateView.onUpdate(state)
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
        
        public static let none = StateModel(.none)
        
        public static let loading = StateModel(.loading)
        
        public static let success = StateModel(.success)
        
        public static func failure(_ error: Error, action: Action?) -> Self {
            return StateModel(.failure(error), action: action)
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
        public let activityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            $0.hidesWhenStopped = true
            #if os(tvOS)
            $0.style = .whiteLarge
            #endif
            #if os(iOS)
            $0.style = .gray
            #endif
            return $0
        }(UIActivityIndicatorView(style: .whiteLarge))
        #else
        public let activityIndicatorView: UIActivityIndicatorView = {
            $0.isHidden = true
            $0.hidesWhenStopped = true
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
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
            
            return $0
        }(UIStackView())
        
        init(model: StateType) {
            
            self.model = model
            super.init(frame: .zero)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func onUpdate(_ model: StateType) {
            
            imageView.image = model.image
            titleLabel.text = model.title
            descriptionLabel.text = model.description
            actionButton.setTitle(model.actionTitle, for: UIControl.State())
            if case .loading = model.state {
                
                activityIndicatorView.startAnimating()
                
            } else if case .success = model.state {
                
                activityIndicatorView.stopAnimating()
                isHidden = true
                
            } else if case .failure = model.state {
               
                activityIndicatorView.stopAnimating()
                isHidden = false
                
            } else {
                /// `none`
                isHidden = true
            }
            
            imageView.isHidden = imageView.image == nil
            titleLabel.isHidden = titleLabel.text == nil
            descriptionLabel.isHidden = descriptionLabel.text == nil
            actionButton.isHidden = model.action == nil
            
            verticalStackView.isHidden = imageView.isHidden && descriptionLabel.isHidden && actionButton.isHidden
            
        }
        
    }
    
}
