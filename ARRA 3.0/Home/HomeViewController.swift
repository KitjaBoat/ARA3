//
//  HomeViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit
import DropDown

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchTableButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    let homeViewModel = HomeViewModel()
    var allowModule:[String]?
    var jobList:[JobDetail]?
    let dropMenu = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register((UINib(nibName: "ModuleCellCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "ModuleCellCollectionViewCell")
        allowModule = LoginResponse.current?.allowModule
        collectionView.reloadData()
        checkPassword()
        checkResponseCache()
        
        //set button leftside
        switchTableButton.leftImage(image: UIImage(named: "ic_menu_on_progress_active")!, renderMode: .alwaysOriginal)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
        
        allowModule = LoginResponse.current?.allowModule
        loadData()
        
        DataFortableView.allowmoduleFortableView = LoginResponse.current?.allowModule
        
        
        
        dropMenu.dataSource = (allowModule!)
        dropMenu.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        dropMenu.customCellConfiguration = {index, title, cell in
            guard let cell = cell as? CustomDropDownCell else {
                return
            }
            if title == "NewJob"{
                cell.iconImage.image = UIImage(named: "ic_new_job")
            }else if title == "JobList"{
                cell.iconImage.image = UIImage(named: "ic_status_progress")
            }else if title == "RejectHistory"{
                cell.iconImage.image = UIImage(named: "ic_new_job")
            }
        }
    }
    
    @IBAction func reFresh(_ sender: Any) {
        CacheManager.delete(key: "LOGIN_CACHE")
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        homeViewModel.loadJobData { joblist in
            let mockupJob = joblist[0]
            
            var jobListForTable = [JobDetail]()
            for _ in 1...5 {
                jobListForTable.append(mockupJob)
            }
            self.jobList = jobListForTable
            
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
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func deleteArray(_ sender: Any) {
        
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return allowModule?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModuleCellCollectionViewCell", for: indexPath) as! ModuleCellCollectionViewCell
        cell.title.text = allowModule?[indexPath.row] ?? "TEST"
        cell.backgroundColor = UIColor(rgb: 0xf75355)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "goToDetail", sender: self)
        performSegue(withIdentifier: "GoToCheckIn", sender: self)
    }
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewJobTableViewCell", for: indexPath) as! NewJobTableViewCell
        
        
        if let job = jobList?[indexPath.row] {
            
            //        cell.titleIcon: job.getIconStatusByStatusID(),
            //        cell.titleFontStyle: nil
            //        cell.subTitleFontStyle: nil
            cell.titleFirstLabel.text = job.jobTitle
            cell.titleSecondLabel.text = job.problem
            cell.subTitleFristIcon.image = UIImage(named: "ic_work_location")
            cell.subTitleFristLabel.text = job.customer.location.address
            cell.subTitleSecondLeftIcon.image = UIImage(named: "ic_work_receive")
            cell.subTitleSecondLeftLabel.text = "\(job.timeline.assignment)"
            cell.subTitleSecondRightIcon.image = UIImage(named: "ic_work_expect")
            cell.subTitleSecondRightLabel.text = "\(job.timeline.condition.slaResponse)"
            cell.subTitleThirdIcon.image = UIImage(named: "ic_work_appoint")
            //            cell.subTitleThirdLabel.text =  job.timeline.appointment
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "JobDetailViewController") as! JobDetailViewController
        vc.job = jobList?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
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
        switchTableButton.setTitle(selectedCell, for: .normal)
        if selectedCell == "JobList" {
            switchTableButton.leftImage(image: UIImage(named: "ic_menu_on_progress_active")!, renderMode: .alwaysOriginal)
        }else {
            switchTableButton.leftImage(image: UIImage(named: "ic_menu_new_job_active")!, renderMode: .alwaysOriginal)
        }
    }
}


