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
    
    var allowModule = DataFortableView.allowmoduleFortableView
    var delegate:PopoverToHomeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //popover size
        self.preferredContentSize = CGSize(width:200 , height:150)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopoverTableViewCell", bundle: nil), forCellReuseIdentifier: "PopoverTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allowModule?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverTableViewCell", for: indexPath) as! PopoverTableViewCell
        guard let allowModule = allowModule else {
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
        default:
            cell.icon.image = UIImage(systemName: "house")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModule = allowModule?[indexPath.row]
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
