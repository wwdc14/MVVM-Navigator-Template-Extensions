import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    public func mapperSuccessfulResult<R: ServiceSuccessVerification>(_ value: R) -> Single<Result<JSON, Error>> {
        return flatMap { .just($0.mapperSuccessfulResult(value)) }
    }
    
    public func mapperResult(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Single<Result<JSON, Error>> {
        return flatMap { .just($0.mapperResult(atKeyPath: keyPath, options: options)) }
    }
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Single<JSON> {
        return flatMap { .just(try $0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperValue(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Single<JSON> {
        return flatMap { .just(try $0.mapperValue(atKeyPath: keyPath, options: options)) }
    }
    
}

extension ObservableType where Element == Response {
    
    public func mapperSuccessfulResult<R: ServiceSuccessVerification>(_ value: R) -> Observable<Result<JSON, Error>> {
        return flatMap { Observable.just($0.mapperSuccessfulResult(value)) }
    }
    
    public func mapperResult(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Observable<Result<JSON, Error>> {
        return flatMap { Observable.just($0.mapperResult(atKeyPath: keyPath, options: options)) }
    }
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Observable<JSON> {
        return flatMap { Observable.just(try $0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperValue(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Observable<JSON> {
        return flatMap { Observable.just(try $0.mapperValue(atKeyPath: keyPath, options: options)) }
    }
}
