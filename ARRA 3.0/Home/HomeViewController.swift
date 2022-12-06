//
//  HomeViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit
class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchTableButton: UIButton!
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let homeViewModel = HomeViewModel()
    var allowModule:[String]?
    var jobList:[JobDetail]?
    var allButtonDatasource:String?
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register((UINib(nibName: "ModuleCellCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "ModuleCellCollectionViewCell")
        allowModule = LoginResponse.current?.allowModule
        collectionView.reloadData()
        checkPassword()
        checkResponseCache()
        
        DataFortableView.allowmoduleFortableView = LoginResponse.current?.allowModule
        
        //loadMjob
        homeViewModel.loadMasterData()
        
        //set button leftside
        switchTableButton.leftImage(image: UIImage(named: "ic_menu_new_job_active")!, renderMode: .alwaysOriginal)
        
        //set alll button color
        allButton.tintColor = UIColor(rgb: 0xf75355)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        
        allowModule = LoginResponse.current?.allowModule
        allowModule?.append(Module.Setting.rawValue)
        
        loadData(modeule: Module.NewJob.rawValue)
        
        
  
        //delegate logout from alert
       
        
        set()
        
        
    }
    
    func loadData(modeule:String) {
        homeViewModel.loadJobData(module:modeule) { joblist in
            print("Number of joblisr\(joblist.count)")
            self.jobList = joblist
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func checkPassword(){
        if let password = UserDefaults.standard.value(forKey: "KEY_USERNAME") as? String{
            let pass = try? KeychainManager.get(username: password)
            print("This is password \(pass)")
        }
    }
    
    func checkResponseCache(){
        print("This is response cache \(LoginResponse.current)")
    }
    
    @IBAction func pickTable(_ sender: Any) {
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverViewController") as? PopoverViewController
        
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        
        popoverContentController?.modalPresentationStyle = .popover
        
        //delegate tab cell
        popoverContentController?.delegate = self
        
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .left
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            if let popoverController = popoverContentController {
                
                popoverController.dataSource =  DataFortableView.allowmoduleFortableView
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func allButtonPress(_ sender: Any) {
        switch allButtonDatasource {
        case Module.NewJob.rawValue:
            performSegue(withIdentifier: "goToNewJob", sender: self)
        case Module.JobList.rawValue:
            performSegue(withIdentifier: "goToJobList", sender: self)
        case Module.RejectHistrory.rawValue:
            performSegue(withIdentifier: "goToRejectHistory", sender: self)
        case Module.Setting.rawValue:
            performSegue(withIdentifier: "goToSetting", sender: self)
        default:
            break
        }
    }
    
    
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allowModule?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModuleCellCollectionViewCell", for: indexPath) as! ModuleCellCollectionViewCell
        var icon:UIImage?
        if let title = allowModule?[indexPath.row] {
            switch title {
            case Module.NewJob.rawValue:
                icon = UIImage(named: "ic_assignment")
            case Module.JobList.rawValue:
                icon = UIImage(named: "ic_job_list")
            case Module.RejectHistrory.rawValue:
                icon = UIImage(named: "ic_assignment")
            case Module.Setting.rawValue:
                icon = UIImage(named: "ic_new_setting")
            default:
                icon = UIImage(named: "ic_new_customer")
            }
            let model = WidGetList(title: title,
                                   icon: icon!)
            cell.model = model
            cell.setupCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch allowModule?[indexPath.row] {
        case Module.NewJob.rawValue:
            performSegue(withIdentifier: "goToNewJob", sender: self)
        case Module.JobList.rawValue:
            performSegue(withIdentifier: "goToJobList", sender: self)
        case Module.RejectHistrory.rawValue:
            performSegue(withIdentifier: "goToRejectHistory", sender: self)
        case Module.Setting.rawValue:
            performSegue(withIdentifier: "goToSetting", sender: self)
        default:
            break
        }
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
        
        
        if let job = jobList?[indexPath.row] {
            cell.titleIcon.image = job.getJobStatus()?.getIcon()
            cell.titleFirstLabel.text = job.jobTitle
            cell.titleSecondLabel.text = job.problem
            cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
            cell.subTitleFristLabel.text = job.customer.location.address
            
            if let timeline = job.timeline {
                cell.subTitleSecondLeftIcon.image = UIImage(named: "ic_work_receive")
                cell.subTitleSecondLeftLabel.text = "\(timeline.assignment)"
                cell.subTitleSecondRightIcon.image = UIImage(named: "ic_work_expect")
                cell.subTitleSecondRightLabel.text = "\(timeline.condition.slaResponse)"
            }
           

            cell.subTitleThirdIcon.image = UIImage(named: "ic_work_appoint")
            //            cell.subTitleThirdLabel.text =  job.timeline.appointment
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        vc.job = jobList?[indexPath.row]
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

extension HomeViewController:PopoverToHomeDelegate {
    func tabOnTableViewCellFromPopover(selectedCell: String) {
        //set image
        allButtonDatasource = selectedCell
        switchTableButton.setTitle(selectedCell, for: .normal)
        if selectedCell == "JobList" {
            switchTableButton.leftImage(image: UIImage(named: "ic_menu_on_progress_active")!, renderMode: .alwaysOriginal)
          
            allButton.tintColor = UIColor(ciColor: CIColor(red: 0.701961, green: 0.533333, blue: 1, alpha: 1))
        }else {
            switchTableButton.leftImage(image: UIImage(named: "ic_menu_new_job_active")!, renderMode: .alwaysOriginal)
            allButton.tintColor = UIColor(rgb: 0xf75355)
        }
        //set new table
        print(selectedCell)
        loadData(modeule: selectedCell)
    }
}

extension HomeViewController{

    func set() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.dismiss(animated: true, completion: nil)

        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "KEY_USERNAME")
       
    }
}

enum Module:String {
    case NewJob = "NewJob"
    case JobList = "JobList"
    case RejectHistrory = "RejectHistory"
    case Setting = "Setting"
    case JobDetail = "JobDetail"
}

