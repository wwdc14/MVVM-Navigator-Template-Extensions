///  Created by `___FULLUSERNAME___` on ___DATE___.

import UIKit
import RxSwift
import RxCocoa
import MVVMRExtensions

class ___VARIABLE_sceneIdentifier___ViewController: UIViewController, StoryboardInstantiable {
    
    lazy var input = ___VARIABLE_sceneIdentifier___ViewModel.Input()
    lazy var viewModel = ___VARIABLE_sceneIdentifier___ViewModel(disposeBag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.viewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        
        /// `transform`
        let output = viewModel.transform(input: input)
        
        /// `binds`
        output.state.drive(rx.state).disposed(by: disposeBag)
        
    }
    
}
