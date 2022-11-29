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
    
    @IBOutlet weak var tableView: UITableView!
    let homeViewModel = HomeViewModel()
    var allowModule:[String]?
    var jobList:[JobDetail]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register((UINib(nibName: "ModuleCellCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "ModuleCellCollectionViewCell")
        allowModule = LoginResponse.current?.allowModule
        collectionView.reloadData()
        checkPassword()
        checkResponseCache()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewJobTableViewCell", bundle: nil), forCellReuseIdentifier: "NewJobTableViewCell")
       
        
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

    @IBAction func reFresh(_ sender: Any) {
//        allowModule = Modules.shared.allow
//        allowModule?.append("Setting")
//        allowModule?.append("CheckIn - CheckOut")
//        print(allowModule)
//        collectionView.reloadData()
        
//        let preferences = UserDefaults.standard
//        preferences.removeObject(forKey: "KEY_USERNAME")
        
        CacheManager.delete(key: "LOGIN_CACHE")
        self.dismiss(animated: true, completion: nil)
        
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
