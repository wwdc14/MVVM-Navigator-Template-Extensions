///  Created by `___FULLUSERNAME___` on ___DATE___.

import UIKit
import RxSwift
import RxCocoa
import MVVMRExtensions

extension ___VARIABLE_sceneIdentifier___ViewModel {
    // MARK: - INPUT
    struct Input {
        // MARK: - INPUT. View event methods
        
    }
    
    // MARK: - OUTPUT
    struct Output {
        //let route: Driver<RoutType>
        let state: Driver<StateType>
        let loading: Observable<LoadingContext>
    }
}

class ___VARIABLE_sceneIdentifier___ViewModel: ViewModelType {
    
    typealias LoadingContext = (isLoading: Bool, error: Error?)
    
    let disposeBag: DisposeBag
    fileprivate let _state = PublishSubject<StateType>()
    fileprivate let _loading = PublishSubject<LoadingContext>()
    
    init(_ disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    func transform(input: Input) -> Output {
        
        return Output(state: _state.asDriver(onErrorJustReturn: UIViewController.StateModel.none), loading: _loading)
    }
 }

