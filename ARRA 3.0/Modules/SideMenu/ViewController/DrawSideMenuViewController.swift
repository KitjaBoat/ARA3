//
//  DrawSideMenuViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

protocol MenuControllerDeleger{
    func cellDidTap(module:String)
}

class DrawSideMenuViewController: UIViewController {

    let transitionManager = DrawerTransitionManager()
    var menuMock:[String]?
    var delegate:MenuControllerDeleger?
    var selectedModule:Module?
    
    init() {
            super.init(nibName: nil, bundle: nil)
            modalPresentationStyle = .custom
            transitioningDelegate = transitionManager
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            
            menuMock = LoginResponse.current?.allowModule
            menuMock?.insert("Profile", at: 0)
            menuMock?.append(Module.Setting.rawValue)
        }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PopoverTableViewCell", bundle: nil), forCellReuseIdentifier: "PopoverTableViewCell")
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //ignore safe area
        tableView.contentInsetAdjustmentBehavior = .never
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
}

extension DrawSideMenuViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuMock?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuMock = menuMock else {return UITableViewCell()}
        
        if menuMock[indexPath.row] == "Profile" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
            cell.nameLabel.text = LoginResponse.current?.user?.name!
            cell.positionLabel.text = LoginResponse.current?.user?.role!
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverTableViewCell", for: indexPath) as! PopoverTableViewCell
            cell.selectionStyle = .default
            cell.label.text = menuMock[indexPath.row]
//            switch menuMock[indexPath.row] {
//            case "JobList":
//                cell.icon.image = UIImage(named: "ic_menu_on_progress")
//            case "NewJob":
//                cell.icon.image = UIImage(named: "ic_menu_new_job")
//            case "RejectHistory":
//                cell.icon.image = UIImage(named: "ic_menu_new_job")
//            default:
//                cell.icon.image = UIImage(named: "ic_menu_setting")
//            }
            
            if let selectedModule = selectedModule {
                
                switch selectedModule {
                case Module.NewJob:
                    switch menuMock[indexPath.row] {
                    case "JobList":
                        cell.icon.image = UIImage(named: "ic_menu_on_progress")
                    case "NewJob":
                        cell.icon.image = UIImage(named: "ic_menu_new_job_active")
                        cell.label.textColor = UIColor(rgb: 0xf75355)
                    case "RejectHistory":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    default:
                        cell.icon.image = UIImage(named: "ic_menu_setting")
                    }
                case Module.JobList:
                    switch menuMock[indexPath.row] {
                    case "JobList":
                        cell.icon.image = UIImage(named: "ic_menu_on_progress_active")
                        cell.label.textColor =
                        UIColor(ciColor: CIColor(red: 0.701961, green: 0.533333, blue: 1, alpha: 1))
                    case "NewJob":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    case "RejectHistory":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    default:
                        cell.icon.image = UIImage(named: "ic_menu_setting")
                    }
                    
                case Module.RejectHistrory:
                    switch menuMock[indexPath.row] {
                    case "JobList":
                        cell.icon.image = UIImage(named: "ic_menu_on_progress")
                    case "NewJob":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    case "RejectHistory":
                        cell.icon.image = UIImage(named: "ic_menu_new_job_active")
                        cell.label.textColor = UIColor(rgb: 0xf75355)
                    default:
                        cell.icon.image = UIImage(named: "ic_menu_setting")
                    }
                    
                case Module.Setting:
                    switch menuMock[indexPath.row] {
                    case "JobList":
                        cell.icon.image = UIImage(named: "ic_menu_on_progress")
                    case "NewJob":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    case "RejectHistory":
                        cell.icon.image = UIImage(named: "ic_menu_new_job")
                    default:
                        cell.icon.image = UIImage(named: "ic_menu_new_setting_active")
                        cell.label.textColor = UIColor(ciColor: CIColor(red: 0.266667, green: 0.392157, blue: 0.509804, alpha: 1))
                    }
                    
                default:
                    break
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuMock = menuMock else {return }
        delegate?.cellDidTap(module: menuMock[indexPath.row])
    }
}


