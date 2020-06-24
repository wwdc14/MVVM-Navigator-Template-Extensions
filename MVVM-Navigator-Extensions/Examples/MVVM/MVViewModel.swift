 
///  Created by `Hy` on 2020/6/24.
 

import RxSwift
import RxCocoa
import Foundation
import UIKit.UIViewController
import MVVMNavigatorExtensions

precedencegroup Precedence {
    lowerThan: AdditionPrecedence
    associativity: none
    assignment: false
}
infix operator <<<: Precedence
func <<<(left: MVViewModel, right: MVViewModel.Input) -> MVViewModel.Output {
    var _left = left
    return _left.transform(input: right)
}

extension MVViewModel {
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

struct MVViewModel: ViewModelType {
     
    let disposeBag: DisposeBag
    fileprivate let _state = PublishSubject<StateType>()
     
    init(_ disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
     
    mutating func transform(input: Input) -> Output {
        
        return Output(state: _state.asDriver(onErrorJustReturn: UIViewController.StateModel.none))
    }
 }

