//
//  PopoverViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 30/11/2565 BE.
//

import UIKit

protocol PopoverToHomeDelegate {
    func tabOnTableViewCellFromPopover(selectedCell:String)
}

class PopoverViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = DataFortableView.allowmoduleFortableView
    var delegate:PopoverToHomeDelegate?
    
    
    var isOpenFromJobList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isOpenFromJobList {
            self.preferredContentSize = CGSize(width:200 , height:150)
        }else{
            self.preferredContentSize = CGSize(width:300 , height:250)
            tableView.isScrollEnabled = true
        }
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopoverTableViewCell", bundle: nil), forCellReuseIdentifier: "PopoverTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverTableViewCell", for: indexPath) as! PopoverTableViewCell
        guard let allowModule = dataSource else {
            return UITableViewCell()
        }
     
        
        cell.label.text = allowModule[indexPath.row]
        switch allowModule[indexPath.row] {
        case "JobList":
            cell.icon.image = UIImage(named: "ic_menu_on_progress_active")
        case "NewJob":
            cell.icon.image = UIImage(named: "ic_menu_new_job_active")
        case "RejectHistory":
            cell.icon.image = UIImage(named: "ic_menu_new_job_active")
        
        //from JoblistInfo
        case JobStatusDetail.Assign.rawValue:
            cell.icon.image = UIImage(named: "ic_status_assign")
        case JobStatusDetail.Accept.rawValue:
            cell.icon.image = UIImage(named: "ic_status_accept")
        case JobStatusDetail.OnTheWay.rawValue:
            cell.icon.image = UIImage(named: "ic_status_progress")
        case JobStatusDetail.Inprogress.rawValue:
            cell.icon.image = UIImage(named: "ic_status_progress")
        case JobStatusDetail.inprogressDone.rawValue:
            cell.icon.image = UIImage(named: "ic_status_finish")
        case JobStatusDetail.Rework.rawValue:
            cell.icon.image = UIImage(named: "ic_status_rework")
        case JobStatusDetail.ReworkUp.rawValue:
            cell.icon.image = UIImage(named: "ic_status_rework")
        case JobStatusDetail.ReworkDown.rawValue:
            cell.icon.image = UIImage(named: "ic_status_rework")
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModule = dataSource?[indexPath.row]
        guard let selectedModule = selectedModule else {return}
        print(selectedModule)
        delegate?.tabOnTableViewCellFromPopover(selectedCell: selectedModule)
        DataFortableView.allowmoduleFortableView = []

        if let cacheAllowModule = LoginResponse.current?.allowModule {
            let filterModule = cacheAllowModule.filter { modul in
                modul != selectedModule
            }
            DataFortableView.allowmoduleFortableView = filterModule
        }
        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

enum JobStatusDetail:String {
    case Assign = "Assign ยังไม่ accept"
    case Accept = "Accept ยังไม่ดำเนินการ"
    case OnTheWay = "กำลังเดินทาง"
    case Inprogress = "ดำเนินการยังไม่แล้วเสร็จ"
    case inprogressDone = "ดำเนินการแล้วเสร็จ"
    case Rework = "(Rework) ดำเนินการแล้วเสร็จ"
    case ReworkUp = "(Rework Up) ดำเนินการแล้วเสร็จ"
    case ReworkDown = "(Rework Down) ดำเนินการแล้วเสร็จ"
    case Reject = "Reject"
}

