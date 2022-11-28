//
//  JobDetailViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit

class JobDetailViewController: UIViewController {
    @IBOutlet weak var firstSection: UITableView!
    @IBOutlet weak var secondSection: UITableView!
    
    var job:JobDetail?
    var jobModel = [JobToSetupTableView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSection.delegate = self
        firstSection.dataSource = self
        firstSection.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        
        secondSection.delegate = self
        secondSection.dataSource = self
        secondSection.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "MapTableViewCell")
        
        setupTableView()

    }
    
    func setupTableView() {
        jobModel = [JobToSetupTableView.init(title: job., icon: <#T##UIImage?#>, handler: <#T##(() -> Void)##(() -> Void)##() -> Void#>)]
        
    }

}

extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == secondSection {
            return jobModel.count
        }else {
            return 1
        }
        
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstSection {
            if let job = job {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
                cell.titleFirstLabel.text = job.jobTitle
                cell.titleSecondLabel.text = job.problem
                cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
                cell.subTitleFristLabel.text = job.customer.location.address
                cell.subTitleSecondLeftIcon.image = UIImage(named: "ic_work_receive")
                cell.subTitleSecondLeftLabel.text = "\(job.timeline.assignment)"
                cell.subTitleSecondRightIcon.image = UIImage(named: "ic_work_expect")
                cell.subTitleSecondRightLabel.text = "\(job.timeline.condition.slaResponse)"
                cell.subTitleThirdIcon.image = UIImage(named: "ic_work_appoint")
                return cell
            }
        }
        else if tableView == secondSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemarkTableViewCell", for: indexPath) as! RemarkTableViewCell
            cell.remark.text = tableViewData[indexPath.row] as! String
            return cell
        }
        return UITableViewCell()
    }
}
