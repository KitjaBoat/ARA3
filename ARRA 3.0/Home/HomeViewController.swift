//
//  HomeViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let homeViewModel = HomeViewModel()
    var allowModule:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register((UINib(nibName: "ModuleCellCollectionViewCell", bundle: nil)), forCellWithReuseIdentifier: "ModuleCellCollectionViewCell")
        
        
        
        allowModule = Modules.shared.allow
        print(allowModule)
        
    }

    @IBAction func reFresh(_ sender: Any) {
        allowModule = Modules.shared.allow
        allowModule?.append("Setting")
        allowModule?.append("CheckIn - CheckOut")
        print(allowModule)
        collectionView.reloadData()
        
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(allowModule?.count)
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
