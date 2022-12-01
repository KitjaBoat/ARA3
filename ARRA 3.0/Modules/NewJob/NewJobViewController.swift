//
//  NewJobViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit


class NewJobViewController: UIViewController {
    let viewModel = NewJobViewModel()
    var jobList:[JobDetail]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        
        viewModel.loadJob { job in
            self.jobList = job
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sideMenu(_ sender: Any) {
       // present menu view
        let drawerController = DrawSideMenuViewController()
            present(drawerController, animated: true)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension NewJobViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
        
        
        if let job = jobList?[indexPath.row] {
            //        cell.titleIcon: job.getIconStatusByStatusID(),
            //        cell.titleFontStyle: nil
            //        cell.subTitleFontStyle: nil
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
//        navigationController?.pushViewController(vc, animated: true)
    }
}

