//
//  AttachFileViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 6/12/2565 BE.
//

import UIKit

class AttachFileViewController: UIViewController {
    
    var attachFileList: [Attachment]?
    var job: Job?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AttachFile"
        setupTableView()
        print("This is AttachFileList \(attachFileList)")

    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AttachFileTableViewCell", bundle: nil), forCellReuseIdentifier: "AttachFileTableViewCell")
    }
}

extension AttachFileViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachFileList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachFileTableViewCell", for: indexPath) as! AttachFileTableViewCell
        guard let attachFileList = attachFileList else {
            return UITableViewCell()
        }
        cell.attachFile = attachFileList[indexPath.row]
        cell.setUpCell()
        cell.setActionOnIcon()
        return cell
    }
    
    
}
