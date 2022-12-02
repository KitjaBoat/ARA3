//
//  JobListViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit



class JobListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = Module.Joblist.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(ciColor: CIColor(red: 0.701961, green: 0.533333, blue: 1, alpha: 1))
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }

}
