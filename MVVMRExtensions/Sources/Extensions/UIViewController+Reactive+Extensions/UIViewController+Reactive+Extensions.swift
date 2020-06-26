import RxSwift
import RxCocoa
import UIKit.UIViewController

extension Reactive where Base: UIViewController {
    
    public var state: Binder<StateType> {
        return Binder(base, binding: { (viewController, state) in
            viewController.onState(state)
        })
    }
    
}

