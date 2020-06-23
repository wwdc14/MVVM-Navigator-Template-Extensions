 
///  Created by `___FULLUSERNAME___` on ___DATE___.
 

import UIKit
import RxSwift
import RxCocoa
import MVVMNavigatorExtensions

class ___VARIABLE_sceneIdentifier___ViewController: UIViewController {
    
    lazy var input = ___VARIABLE_sceneIdentifier___ViewModel.Input()
    lazy var viewModel = ___VARIABLE_sceneIdentifier___ViewModel(disposeBag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.viewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}
