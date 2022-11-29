//
//  LoginViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 24/11/2565 BE.
//

import UIKit
import WebKit
import SafariServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mainBoxView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var switcher: UISwitch!
    
    let loginViewModel = LoginViewModel()
    var webView: WKWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loginViewModel.delegate = self
        switchCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        if let userName = preferences.value(forKey: "KEY_USERNAME"){
            switcher.isOn = true
            switchCheck()
            do {
                let (userName,password) = try KeychainManager.get(username: userName as! String)
                DispatchQueue.main.async {
                    self.userNameTextField.text = userName
                    self.passwordTextField.text = password
                }
            } catch  {
                print( error )
            }
            autoLogin()
        }else {
            switcher.isOn = false
            switchCheck()
        }
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        let (result, message) = loginViewModel.loginChecker(
            userName: userNameTextField.text,
            password: passwordTextField.text)
        if result {
            loginViewModel.startLogin { isSuccess, message in
                if isSuccess {
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }else {
                    AlertManager.alertLogin(messae: message, self: self)
                }
            }
        }else {
            AlertManager.alertLogin(messae: message, self: self)
        }
    }
    
    @IBAction func switcher(_ sender: Any) {
        switchCheck()
    }
    
    func setUpView(){
        mainBoxView.layer.cornerRadius = 10
        buttonLogin.titleLabel?.numberOfLines = 1
    }
    
    func switchCheck(){
        if switcher.isOn == true {
            loginViewModel.switcherIsOn = true
        }else if switcher.isOn == false {
            loginViewModel.switcherIsOn = false
        }
    }
    
    func autoLogin() {
        let loginResponseFromCache = CacheManager.get(key: "LOGIN_CACHE")
        guard let loginResponseFromCache = loginResponseFromCache else {
            return
        }
        LoginResponse.current = loginResponseFromCache
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func OpenWebViewForForgetPassword(_ sender: Any) {
        let myURL = URL(string:"http://aservicetapi.ar.co.th/ForgotPassword"  )
        let vc = SFSafariViewController(url: myURL!)
        present(vc, animated: true, completion: nil)
    }
}
    
extension LoginViewController:ClearTextField{
    func clertext() {
        DispatchQueue.main.async {
            self.userNameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
}

    



