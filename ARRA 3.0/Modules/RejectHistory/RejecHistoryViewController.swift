//
//  RejecHistoryViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 1/12/2565 BE.
//

import UIKit

class RejecHistoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = Module.RejectHistrory.rawValue
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgb: 0xf75355)
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
