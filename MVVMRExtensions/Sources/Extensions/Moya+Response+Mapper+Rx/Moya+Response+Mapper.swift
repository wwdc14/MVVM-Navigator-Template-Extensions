import Moya
import SwiftyJSON
import Foundation

public enum MapperError: Swift.Error, LocalizedError {
    case status(String)
    public var errorDescription: String? {
        switch self {
        case .status(let s): return s
        }
    }
}

public extension Response {
    
    func mapperSuccessfulResult<R: ServiceSuccessVerification>(_ value: R) -> Result<JSON, Error> {
        do {
            let result = try mapperSuccessfulValue(value)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func mapperResult(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) -> Result<JSON, Error> {
        do {
            let value = try mapperValue(atKeyPath: keyPath, options: options)
            return .success(value)
        } catch {
            return .failure(error)
        }
    }
    
    
    func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) throws -> JSON {
       
        let result = try mapperValue()
        let statusCode = result[value.statusKey].intValue
        if value.statusCodes.contains(statusCode) {
            return result[value.contentKey]
        } else {
            if let errorMessage = result[value.messageKey].string {
                throw MapperError.status(errorMessage)
            } else {
                return result
            }
        }
        
    }
    
    func mapperValue(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) throws -> JSON {
        do {
            let json = try JSON(data: data, options: options)
            if let keyPath = keyPath {
                return json[keyPath]
            } else {
                return json
            }
        } catch {
            throw error
        }
    }
    
}
