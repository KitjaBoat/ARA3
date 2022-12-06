//
//  NewJobViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit


class NewJobViewController: BaseViewController {
    let detailViewModel = NewJobViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.loadJob { job in
            self.jobList = job

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        setupNavigationBar()
       
    }
    
    func setupNavigationBar() {
        title = Module.NewJob.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgb: 0xf75355)
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

