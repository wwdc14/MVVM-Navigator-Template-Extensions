//
//  TViewController.swift
//  Examples
//
//  Created by Hy on 2020/6/22.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit
import MVVMNavigatorExtensions

class TViewController: UIViewController {

    enum Errors: Error {
        case fail
    }
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.flag = true
        }
        let fail = Errors.fail
        var failure = StateModel.failure(fail, action: {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                var loading = StateModel.loading
                loading.actionTitle = "取消"
                loading.description = "正在加载中..."
                self.onState(loading)
            }
        })
        failure.title = "提示"
        failure.actionTitle = "重试"
        failure.description = fail.localizedDescription
        onState(failure)
        // Do any additional setup after loading the view.
    }
    
    override var canGoback: Bool {
        if !flag {
            let alert = UIAlertController(title: "提示", message: "当前禁止返回🔙！", preferredStyle: .alert)
            alert.addAction(.init(title: "确定", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return flag
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
