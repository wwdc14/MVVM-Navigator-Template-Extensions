///  Created by `___FULLUSERNAME___` on ___DATE___.

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: ___VARIABLE_sceneIdentifier___ViewController {
    
    /// Bind some
    var loading: Binder<___VARIABLE_sceneIdentifier___ViewModel.LoadingContext> {
        Binder<___VARIABLE_sceneIdentifier___ViewModel.LoadingContext>(base) { (vc, context) in
            if context.isLoading {
                vc.hud.show("请稍后...", state: .wait)
            } else {
                if let error = context.error {
                    vc.hud.show(error.localizedDescription, state: .error)
                } else {
                    vc.hud.hide(animated: true)
                }
            }
        }
    }
    
}

