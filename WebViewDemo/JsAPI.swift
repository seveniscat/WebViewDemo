//
//  JsAPI.swift
//  WebViewDemo
//
//  Created by Bing on 2021/1/25.
//

import UIKit
import dsBridge

class JsAPI: NSObject {
    var holder: ViewController
    
    init(holder: ViewController) {
//        super.init()
        self.holder = holder
    }
    
    @objc func onLogin(_ arg:String) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.loginSuccess = { (name, psw) in
            self.holder.webView.callHandler("addValue", arguments: [name ?? "", psw ?? ""])
        }
        self.holder.present(loginVC, animated: true, completion: nil)
    }

}
