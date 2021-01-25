//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Bing on 2021/1/20.
//

import UIKit
import WebKit
import dsBridge

class ViewController: UIViewController {
    lazy var webView: DWKWebView! = {
        let dwk = DWKWebView()
        dwk.dsuiDelegate = self
        return dwk
//        let config = WKWebViewConfiguration()
//        let usercontent = WKUserContentController()
//        //  window.webkit.messageHandlers.jsCallNative.postMessage(data)
//        usercontent.add(self, name: "jsCallNative")
//        config.userContentController = usercontent
//        let wk = WKWebView(frame: .null, configuration: config)
//        wk.uiDelegate = self
//        wk.navigationDelegate = self
//
//        return wk
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        view.addSubview(webView)
        webView.addJavascriptObject(JsAPI(holder: self), namespace: nil)
        
        let request = URLRequest(url: URL(string: "http://127.0.0.1:8848/DSTest/index.html")!)
        webView.load(request)
    }
    @IBAction func refresh(_ sender: UIButton) {
        self.webView.stopLoading()
        self.webView.reload()
    }
    
    @IBAction func callJS(_ sender: UIButton) {
        
        self.webView.callHandler("jscall", arguments: [1,2,3])
//        webView.callHandler(<#T##methodName: String##String#>, arguments: <#T##[Any]?#>, completionHandler: <#T##((Any?) -> Void)?##((Any?) -> Void)?##(Any?) -> Void#>)
//        self.webView.evaluateJavaScript("jscall('hello js!')") { (result, error) in
//        }
    }
    
    
    func jscall(_ body: Any) {
        print(body)
    }
    
}

extension ViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "jsCallNative" {
            self.jscall(message.body)
        }
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
        completionHandler()

    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }

//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//    }

}

