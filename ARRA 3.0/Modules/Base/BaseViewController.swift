//
//  BaseViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class BaseViewController: UIViewController {
    let drawerController = DrawSideMenuViewController()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let menuButton = UIButton(type: UIButton.ButtonType.system)
        menuButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButton.addTarget(self, action: #selector(openSideMnu), for:    .touchUpInside)
        menuButton.setImage(UIImage(named: "ic_menu"), for: UIControl.State())
        let menuBarButtonItem = UIBarButtonItem(customView: menuButton)
        
       

        let menuButtonRight = UIButton(type: UIButton.ButtonType.system)
        menuButtonRight.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButtonRight.addTarget(self, action: #selector(disMiss), for:    .touchUpInside)
        menuButtonRight.setImage(UIImage(named: "ic_home"), for: UIControl.State())
        let menuBarButtonItemRight = UIBarButtonItem(customView: menuButtonRight)

        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        navigationItem.rightBarButtonItem = menuBarButtonItemRight
        
        setObserver()
    }
    
    @objc func openSideMnu() {
       
        drawerController.delegate = self
        present(drawerController, animated: true)
    }
    
    @objc func disMiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification), name: Notification.Name("goHome"), object: nil)
    }
    
    @objc func methodOfReceivedNotification() {
        drawerController.dismiss(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension BaseViewController:MenuControllerDeleger {
    func cellDidTap(module: String) {
        switch module {
        case Module.Newjob.rawValue:
            let checkInVc = storyboard?.instantiateViewController(withIdentifier: "NewJobViewController") as! NewJobViewController
            navigationController?.pushViewController(checkInVc, animated: false)
            self.dismiss(animated: true, completion: nil)
        case Module.Joblist.rawValue:
            let checkInVc = storyboard?.instantiateViewController(withIdentifier: "JobListViewController") as! JobListViewController
            navigationController?.pushViewController(checkInVc, animated: false)
            self.dismiss(animated: true, completion: nil)
        case Module.RejectHistrory.rawValue:
            let checkInVc = storyboard?.instantiateViewController(withIdentifier: "RejecHistoryViewController") as! RejecHistoryViewController
            navigationController?.pushViewController(checkInVc, animated: false)
            self.dismiss(animated: true, completion: nil)
        case Module.Setting.rawValue:
            let checkInVc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            navigationController?.pushViewController(checkInVc, animated: false)
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    
}
