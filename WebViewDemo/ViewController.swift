//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Bing on 2021/1/20.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    lazy var webView: WKWebView! = {
        let config = WKWebViewConfiguration()
        let usercontent = WKUserContentController()
        //  window.webkit.messageHandlers.jsCallNative.postMessage(data)
        usercontent.add(self, name: "jsCallNative")
        config.userContentController = usercontent
        let wk = WKWebView(frame: .null, configuration: config)
        wk.uiDelegate = self
        wk.navigationDelegate = self
        
        return wk
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        view.addSubview(webView)
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        webView.load(request)
    }
    @IBAction func refresh(_ sender: UIButton) {
        self.webView.stopLoading()
        self.webView.reload()
    }
    
    @IBAction func callJS(_ sender: UIButton) {
        self.webView.evaluateJavaScript("jscall('from native')") { (result, error) in
            
        }
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
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//    }
    
}

