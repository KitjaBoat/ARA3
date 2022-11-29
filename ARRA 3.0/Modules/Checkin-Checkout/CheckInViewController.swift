//
//  CheckInViewController.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 28/11/2565 BE.
//

import UIKit
import CoreLocation
import MapKit

class CheckInViewController: UIViewController,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgb: 0xf75355)
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        //        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    
    @IBAction func checkIn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.location = locationManager.location?.coordinate
        
        navigationController?.pushViewController(vc, animated:  true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location:CLLocation) {let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        map.setRegion(region, animated: true)
    }
    
    @IBAction func checkOut(_ sender: Any) {
    }
    
    @IBAction func goToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
