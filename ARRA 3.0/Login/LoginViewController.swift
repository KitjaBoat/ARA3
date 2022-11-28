//
//  LoginViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 24/11/2565 BE.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mainBoxView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    let loginViewModel = LoginViewModel()
    var allowModule = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBoxView.layer.cornerRadius = 10
        buttonLogin.titleLabel?.numberOfLines = 1
        //        var bottomLine = CALayer()
        ////        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
        //        bottomLine.backgroundColor = UIColor.white.cgColor
        //        userNameTextField.borderStyle = UITextField.BorderStyle.none
        //        userNameTextField.layer.addSublayer(bottomLine)
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        login()
        
         let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
         vc.allowModule = self.allowModule
            vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
    }
   
    
    @IBAction func switcher(_ sender: Any) {
    }
    
    
    
    func login() {
//        guard let username = userNameTextField.text , let password = passwordTextField.text else {
//            return
//        }
        loginViewModel.apiPost(username:"" , password: "") { data in
          
            print("GG")
     
         
        }
       
    }
    
}


