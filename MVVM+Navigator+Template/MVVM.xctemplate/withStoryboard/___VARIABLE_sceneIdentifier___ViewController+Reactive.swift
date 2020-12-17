///  Created by `___FULLUSERNAME___` on ___DATE___.

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: ___VARIABLE_sceneIdentifier___ViewController {
    
    /// Bind some
    var loading: Binder<___VARIABLE_sceneIdentifier___ViewModel.HUD> {
        Binder<___VARIABLE_sceneIdentifier___ViewModel.HUD>(base) { (vc, context) in
            if context.isLoading {
                vc.hud.show(context.text, state: .wait)
            } else {
                if let error = context.error {
                    vc.hud.show(error.localizedDescription, state: .error)
                } else {
                    if context.text.isBlank {
                        vc.hud.hide(animated: true)
                    } else {
                        vc.hud.show(context.text, state: .success)
                    }
                }
            }
        }
    }
    
}

