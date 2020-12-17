///  Created by `___FULLUSERNAME___` on ___DATE___.

import UIKit
import RxSwift
import RxCocoa
import MVVMRExtensions

class ___VARIABLE_sceneIdentifier___ViewController: UIViewController {
    
    lazy var input = ___VARIABLE_sceneIdentifier___ViewModel.Input()
    lazy var viewModel = ___VARIABLE_sceneIdentifier___ViewModel(disposeBag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        
        /// `transform`
        let output = viewModel.transform(input: input)
        
        /// `binds`
        output.loading.bind(to: rx.loading).disposed(by: disposeBag)
        
    }
    
}
