 
///  Created by `Hy` on 2020/6/29.
 

import RxSwift
import RxCocoa
import Foundation
import MVVMRExtensions
import UIKit.UIViewController

precedencegroup Precedence {
    lowerThan: AdditionPrecedence
    associativity: none
    assignment: false
}
infix operator <<<: Precedence
func <<<(left: ListerViewModel, right: ListerViewModel.Input) -> ListerViewModel.Output {
    return left.transform(input: right)
}

extension ListerViewModel {
    // MARK: - INPUT
    struct Input {
        // MARK: - INPUT. View event methods
        let viewDidLoad: PublishSubject<Void> = .init()
    }
     
    // MARK: - OUTPUT
    struct Output {
        //let route: Driver<RoutType>
        let state: Driver<StateType>
    }
}

class ListerViewModel: ViewModelType {
     
    let disposeBag: DisposeBag
    fileprivate let _state = PublishSubject<StateType>()
     
    init(_ disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
     
    func transform(input: Input) -> Output {
        
        input.viewDidLoad.subscribe { _ in
            self._state.onNext(UIViewController.StateModel.loading("载入中...", description: "请稍后..."))
        }.disposed(by: disposeBag)
        
        
        return Output(state: _state.asDriver(onErrorJustReturn: UIViewController.StateModel.none))
    }
 }

