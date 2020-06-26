import UIKit.UIFont
extension UIFont {
    static public func medium(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .medium) }
    static public func regular(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .regular) }
    static public func black(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .black) }
    static public func bold(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .bold) }
    static public func heavy(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .heavy) }
    static public func light(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .light) }
    static public func semibold(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .semibold) }
    static public func thin(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .thin) }
    static public func ultraLight(_ ofSize: CGFloat) -> UIFont { .systemFont(ofSize: ofSize, weight: .ultraLight) }
}
