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
        let loading: Observable<HUD>
    }
}

class ___VARIABLE_sceneIdentifier___ViewModel: ViewModelType {
    
    struct HUD {
        let isLoading: Bool
        var text: String = ""
        var error: Error? = nil
    }
    
    let disposeBag: DisposeBag
    fileprivate let _loading = PublishSubject<HUD>()
    
    init(_ disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    func transform(input: Input) -> Output {
        
        return Output(loading: _loading)
    }
 }

