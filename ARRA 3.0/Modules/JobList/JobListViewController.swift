//
//  JobListViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit



class JobListViewController: BaseViewController {
    let viewModel = JobListViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        viewModel.loadJobData { job in
            self.jobList = job
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        
        
        
        //        setBarItem()
    }
    
    func setupNavigationBar() {
        title = Module.JobList.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(ciColor: CIColor(red: 0.701961, green: 0.533333, blue: 1, alpha: 1))
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let homeButton = UIBarButtonItem(image: UIImage(named: "ic_home"),  style: .plain, target: self, action: #selector(disMiss))
        
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"),  style: .plain, target: self, action: #selector(openInfo))
        
        
        
        navigationItem.rightBarButtonItems = [homeButton,infoButton ]
    }
    
    @objc func openInfo() {
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverViewController") as? PopoverViewController
        
        //        let button = navigationItem.rightBarButtonItem as? UIButton
        //
        //        let buttonFrame = button?.frame ?? CGRect.zero
        popoverContentController?.modalPresentationStyle = .popover
        
        
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: 335, y: 100, width: 10, height: 10)
            popoverPresentationController.delegate = self
            if let popoverController = popoverContentController {
                guard let master = MasterData.mJobStatus else {return}
                var arrayJobStatus = [String]()
                for detail in master {
                    arrayJobStatus.append(detail.detail)
                }
                popoverController.dataSource = arrayJobStatus
                popoverController.isOpenFromJobList = true
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
}

extension JobListViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}



