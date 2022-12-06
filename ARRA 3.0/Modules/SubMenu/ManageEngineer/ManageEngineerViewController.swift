//
//  ManageEngineerViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 6/12/2565 BE.
//

import UIKit

class ManageEngineerViewController: UIViewController {
    var engineerList: [Engineer]?
    var job: Job?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ManageEngineerTableViewCell", bundle:  nil), forCellReuseIdentifier: "ManageEngineerTableViewCell")
    }


}

extension ManageEngineerViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return engineerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageEngineerTableViewCell", for: indexPath) as! ManageEngineerTableViewCell
        guard let engineer = engineerList?[indexPath.row] else {return UITableViewCell()}
        cell.engineer = engineer
        return cell
    }
    
    
}
