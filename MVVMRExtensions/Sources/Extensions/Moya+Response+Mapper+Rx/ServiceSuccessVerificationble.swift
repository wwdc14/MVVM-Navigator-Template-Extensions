import Foundation

public protocol ServiceSuccessVerification {
    var statusCodes: [Int] { get }
    var statusKey: String { get }
    var messageKey: String { get }
    var contentKey: String { get }
}
