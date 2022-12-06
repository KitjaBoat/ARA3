//
//  RejecHistoryViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class RejecHistoryViewController: BaseViewController {
    let rejectViewModel = RejecHistoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        rejectViewModel.loadJobData { job in
            self.jobList = job
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.register(UINib(nibName: "RejectTableViewCell", bundle: nil), forCellReuseIdentifier: "RejectTableViewCell")
    }
    
    func setupNavigationBar() {
        title = Module.RejectHistrory.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgb: 0xf75355)
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RejectTableViewCell") as! RejectTableViewCell
        
        guard let job = jobList?[indexPath.row] else {return UITableViewCell()}
        
        cell.titleIcon.image = UIImage(named: "ic_status_assign")
        cell.titleFirstLabel.text = job.jobTitle
        cell.titleSecondLabel.text = job.problem
        cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
        cell.subTitleFristLabel.text = job.customer.location.address
        cell.subTitleSecondLeftLabel.text = "Reject Date"
        cell.subTitleSecondRightLabel.text = "\(job.rejectedDate)"
        cell.subTitleThirdLeftLabel.text = "Reject By"
        cell.subTitleThirdRightLabel.text = job.rejectedBy ?? "-"
        cell.buttomSecondLabel.text = job.rejectedReason ?? "-"
        cell.buttomFristLabel.text = "Reason"
        
        
        return cell
    }
    
}
