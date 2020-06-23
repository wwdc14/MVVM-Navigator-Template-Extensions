 
///  Created by `___FULLUSERNAME___` on ___DATE___.
 

import RxSwift
import RxCocoa
import Foundation
import MVVMNavigatorExtensions

precedencegroup Precedence {
    lowerThan: AdditionPrecedence
    associativity: none
    assignment: false
}
infix operator <<<: Precedence
func <<<(left: ___VARIABLE_sceneIdentifier___ViewModel, right: ___VARIABLE_sceneIdentifier___ViewModel.Input) -> ___VARIABLE_sceneIdentifier___ViewModel.Output {
    var _left = left
    return _left.transform(input: right)
}

extension ___VARIABLE_sceneIdentifier___ViewModel {
    // MARK: - INPUT
    struct Input {
        // MARK: - INPUT. View event methods
        let viewDidLoad: PublishSubject<Void> = .init()
    }
     
    // MARK: - OUTPUT
    struct Output {
        //let route: Driver<RoutType>
    }
}

struct ___VARIABLE_sceneIdentifier___ViewModel: ViewModelType {
     
    let disposeBag: DisposeBag
     
    init(_ disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
     
    mutating func transform(input: Input) -> Output {
        
        return Output()
    }
 }

