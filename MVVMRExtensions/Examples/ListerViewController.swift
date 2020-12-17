 
///  Created by `Hy` on 2020/6/29.
 

import UIKit
import RxSwift
import RxCocoa
import MVVMRExtensions

class ListerViewController: UIViewController, StoryboardInstantiable {
    
    lazy var input = ListerViewModel.Input()
    lazy var viewModel = ListerViewModel(disposeBag)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.viewDidLoad.onNext(())
    }
    
    override func onec_viewWillAppear() {
        super.onec_viewWillAppear()
    }
    
    override func bindViewModel() {
        
        /// `transform`
        let output = viewModel <<< input
        
        /// `binds`
        
    }
    
}
