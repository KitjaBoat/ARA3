//
//  SettingViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

protocol SettingDelegate {
    func settingLogout()
}

class SettingViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var settingViewModel = SettingViewModel()
    var settingDatasource:[User?]?
    var delegate:SettingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        settingDatasourceFortableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        logoutButton.tintColor = UIColor(ciColor: CIColor(red: 0.266667, green: 0.392157, blue: 0.509804, alpha: 1)) 
        
    }
    
    func settingDatasourceFortableView() {
        settingDatasource = settingViewModel.setupDataForTableView()
        tableView.reloadData()
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(ciColor: CIColor(red: 0.266667, green: 0.392157, blue: 0.509804, alpha: 1))
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = Module.Setting.rawValue
    }
    
    @IBAction func logOut(_ sender: Any) {
//        let alert = AlertManager()
//        alert.alertLogout(view: self)
        self.delegate?.settingLogout()
        let alert = UIAlertController(title: "", message: "คุณต้องการออกจาระบบ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: {_ in
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
            })
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingDatasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        guard let model = settingDatasource else {
            return UITableViewCell()
        }
        cell.user = model[indexPath.row]
        cell.setup()
        return cell
    }
}
