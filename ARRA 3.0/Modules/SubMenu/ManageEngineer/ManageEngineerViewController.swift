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
        setupNavigationItm()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ManageEngineerTableViewCell", bundle:  nil), forCellReuseIdentifier: "ManageEngineerTableViewCell")
    }
    
    func setupNavigationItm() {
        title = "Manage Engineer"
        let menuButtonRight = UIButton(type: UIButton.ButtonType.system)
        menuButtonRight.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuButtonRight.addTarget(self, action: #selector(actionSaveOnNavigationBar), for:    .touchUpInside)
        menuButtonRight.setImage(UIImage(named: "ic_save_gray"), for: .normal)
        let menuBarButtonItemRight = UIBarButtonItem(customView: menuButtonRight)
        navigationItem.rightBarButtonItem = menuBarButtonItemRight
    
    }
    
    @objc func actionSaveOnNavigationBar() {
        pushData(completionhanler: { alert in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    func pushData(completionhanler:@escaping(_ alert:String)->Void) {
        let url = URL(string: "http://app.ar.co.th/AppStoreSystem/files/project/arra_new/success.json")
       
        
        let reqBody = RequestBody(module: "NewJob",
                                  target: "UpdateData",
                                  data: nil)
        
        let jsonData = try? JSONEncoder().encode(reqBody)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
               
                if httpResponse.statusCode == 200 {
                    print(httpResponse.statusCode)
                    completionhanler("Done")
                }
                else {
                    print("errorStatusCode \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
        
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
        cell.checkLead()
        cell.checkAccepted()
        cell.setupCell()
        return cell
    }
    
    
}
