////
////  CentralViewController.swift
////  ARRA 3.0
////
////  Created by ARSOFT on 1/12/2565 BE.
////
//
//import UIKit
//import SideMenu
//
//class CentralViewController: UIViewController {
//
//
//
//
//    var sideMenu:SideMenuNavigationController?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //sidemenu
//        let menu = SideMenuViewController(menu: (LoginResponse.current?.allowModule)!)
////        menu.delegate = self
//        sideMenu = SideMenuNavigationController(rootViewController:menu)
//        sideMenu?.leftSide = true
//        SideMenuManager.default.leftMenuNavigationController = sideMenu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//
//        setupNavigationBar()
//
//    }
//
//    // MARK: Action
//
//    @IBAction func sideMenu(_ sender: Any) {
//        present(sideMenu!, animated: true, completion: nil)
//    }
//
//    @IBAction func backToHome(_ sender: Any) {
//        self.dismiss(animated: true)
//    }
//    
//
//    func setupNavigationBar(){
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(rgb: 0xf75355)
//        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
//                                          .foregroundColor: UIColor.white]
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
////        navigationController?.navigationBar.backgroundColor = UIColor(rgb: 0xf75355)
//    }
//
//
//}
//
//
////extension CentralViewController:MenuControllerDeleger{
////    func cellDidTap(module: String) {
////        print(module)
////        performSegue(withIdentifier: "b", sender: self)
////    }
//
//
////            self.navigationController?.dismiss(animated: true, completion: nil)
//
//
//
////        self.dismiss(animated: true, completion: nil)
////        switch module {
////        case Module.Newjob.rawValue:
////            <#code#>
////        case Module.Joblist.rawValue:
////            <#code#>
////        case Module.RejectHistrory.rawValue:
////            <#code#>
////        case Module.Setting.rawValue:
////            <#code#>
////        default:
////            <#code#>
////        }
//    }
//
//
//
//
//
