//
//  LoginViewController.swift
//  WebViewDemo
//
//  Created by Bing on 2021/1/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var pswTF: UITextField!
    
    var loginSuccess: ((String?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func login(_ sender: UIButton) {
        if loginSuccess != nil {
            loginSuccess!(nameTF.text, pswTF.text)
        }
        self.dismiss(animated: true, completion: nil)
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
