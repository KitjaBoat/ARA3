//
//  SideMenuViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 30/11/2565 BE.
//

import UIKit

protocol MenuControllerDeleger{
    func cellDidTap(module:String)
}

class SideMenuViewController: UITableViewController {
    var menuMock:[String]
    var delegate:MenuControllerDeleger?

    init(menu:[String]) {
        self.menuMock = menu
        super.init(nibName: nil, bundle: nil)
        tableView.register(UINib(nibName: "PopoverTableViewCell", bundle: nil), forCellReuseIdentifier: "PopoverTableViewCell")
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TEST
        menuMock.append("Setting")
        menuMock.append("Profile")
        menuMock.swapAt(4, 0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuMock.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if menuMock[indexPath.row] == "Profile" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
            cell.nameLabel.text = LoginResponse.current?.user?.name!
            cell.positionLabel.text = LoginResponse.current?.user?.role!
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverTableViewCell", for: indexPath) as! PopoverTableViewCell
            
            cell.label.text = menuMock[indexPath.row]
            switch menuMock[indexPath.row] {
            case "JobList":
                cell.icon.image = UIImage(named: "ic_menu_on_progress_active")
            case "NewJob":
                cell.icon.image = UIImage(named: "ic_menu_new_job_active")
            case "RejectHistory":
                cell.icon.image = UIImage(named: "ic_menu_new_job_active")
            default:
                cell.icon.image = UIImage(systemName: "house")
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellDidTap(module: menuMock[indexPath.row])
    }
}
