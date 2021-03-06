import UIKit.UINavigationController
import UIKit.UIViewController
import Foundation.NSURL
import URLNavigator
import URLMatcher


public protocol RoutType: Codable {
    
    var scheme: String { get }
    
    var host: String { get }
    
    var components: URLComponents { get }
    
    var urlString: String { get }
    
    var url: URL { get }
    
    static var registerPattern: String { get }
    
}

extension RoutType {
    public var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        if let encoder = try? JSONEncoder().encode(self),
            let param = try? JSONSerialization.jsonObject(with: encoder, options: .allowFragments) as? [String : String] {
            var items: [URLQueryItem] = components.queryItems ?? []
            for item in param {
                if item.key != "scheme" || item.key != "host" || item.key == "components" || item.key == "url" {
                    items.append(.init(name: item.key, value: item.value))
                }
            }
            components.queryItems = items
        }
        
        return components
    }
    public var url: URL {
        return components.url!
    }
    public var urlString: String {
        return components.url?.absoluteString ?? ""
    }
}


extension NavigatorType {
    
    public func register(_ rout: RoutType, _ factory: @escaping ViewControllerFactory) {
        guard let url = rout.urlString.removingPercentEncoding else { fatalError("register failure! reason: because rout Conversion failed \(rout)") }
        register(url, factory)
    }
    
    @discardableResult
    public func pushRout(_ rout: RoutType,
                         param: [String: Any] = [:],
                         context: Any? = nil,
                         from: URLNavigator.UINavigationControllerType? = nil,
                         animated: Bool = true) -> UIViewController? {
        return pushURL(rout.url, context: context, from: from, animated: animated)
    }
    
    @discardableResult
    public func presentRout(_ rout: RoutType,
                            param: [String: Any] = [:],
                            context: Any? = nil,
                            wrap: UINavigationController.Type? = nil,
                            from: UIViewControllerType? = nil,
                            animated: Bool = true,
                            completion: (() -> Void)? = nil) -> UIViewController? {
        return presentURL(rout.url, context: context, wrap: wrap, from: from, animated: animated, completion: completion)
    }
    
    @discardableResult
    public func openRout(_ rout: RoutType,
                         param: [String: Any] = [:],
                         context: Any? = nil) -> Bool {
        return openURL(rout.url, context: context)
    }
    
}
