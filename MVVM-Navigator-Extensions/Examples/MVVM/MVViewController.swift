 
///  Created by `Hy` on 2020/6/24.
 

import UIKit
import RxSwift
import RxCocoa
import MVVMNavigatorExtensions

class MVViewController: UIViewController {
    
    lazy var input = MVViewModel.Input()
    lazy var viewModel = MVViewModel(disposeBag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.viewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        
        /// `transform`
        let output = viewModel <<< input
        
        /// `binds`
        output.state.drive(rx.state).disposed(by: disposeBag)
        
    }
    
}
