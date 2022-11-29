//
//  MapViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 28/11/2565 BE.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
//    let lat:CLLocationDegrees?
//    let lon:CLLocationDegrees?
    var location : CLLocationCoordinate2D!
    
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is map \(location)")
        
    }
    override func viewWillLayoutSubviews() {
        pin()
    }
    
    func pin() {
        let pin = MKPointAnnotation()
        pin.coordinate = location
       
        
        
//
        map.setRegion(MKCoordinateRegion(center:location, span: MKCoordinateSpan(latitudeDelta: 0.1 , longitudeDelta: 0.1)), animated: true)
        
//        map.set
        
        
        
        map.addAnnotation(pin)
        
    }
   
   

    
    
}
