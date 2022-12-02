//
//  BaseViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class BaseViewController: UIViewController {
    let drawerController = DrawSideMenuViewController()
    var jobList:[JobDetail]?
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNavigationBarItem()
        setupTableView()
        setObserver()
    }
    
    func setupNavigationBarItem() {
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
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //ignore safe area
//        tableView.contentInsetAdjustmentBehavior = .never
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    @objc func openSideMnu() {
        drawerController.delegate = self
        switch title {
        case Module.NewJob.rawValue:
            drawerController.selectedModule = Module.NewJob
        case Module.JobList.rawValue:
            drawerController.selectedModule = Module.JobList
        case Module.RejectHistrory.rawValue:
            drawerController.selectedModule = Module.RejectHistrory
        case Module.Setting.rawValue:
            drawerController.selectedModule = Module.Setting
        default:
            break
        }
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
        case Module.NewJob.rawValue:
            let checkInVc = storyboard?.instantiateViewController(withIdentifier: "NewJobViewController") as! NewJobViewController
            navigationController?.pushViewController(checkInVc, animated: false)
            self.dismiss(animated: true, completion: nil)
        case Module.JobList.rawValue:
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

extension BaseViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobList?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
        
        
        if let job = jobList?[indexPath.row] {
            cell.titleIcon.image = job.getJobStatus()?.getIcon()
            cell.titleFirstLabel.text = job.jobTitle
            cell.titleSecondLabel.text = job.problem
            cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
            cell.subTitleFristLabel.text = job.customer.location.address
            cell.subTitleSecondLeftIcon.image = UIImage(named: "ic_work_receive")
            cell.subTitleSecondLeftLabel.text = "\(job.timeline!.assignment)"
            cell.subTitleSecondRightIcon.image = UIImage(named: "ic_work_expect")
            cell.subTitleSecondRightLabel.text = "\(job.timeline!.condition.slaResponse)"
            cell.subTitleThirdIcon.image = UIImage(named: "ic_work_appoint")
            //            cell.subTitleThirdLabel.text =  job.timeline.appointment
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        vc.job = jobList?[indexPath.row]
    }

}
