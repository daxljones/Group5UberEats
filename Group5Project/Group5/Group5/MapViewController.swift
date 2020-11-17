//
//  MapViewController.swift
//  Group5
//
//  Created by Dax Jones on 11/16/20.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let lM = CLLocationManager()
    
    let regionSize: Double = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        setupRestaurants()

        
    }
    
    func setupRestaurants(){
        
        let coordninates = [
            CLLocation(latitude: 36.1156, longitude: -97.0484),
            CLLocation(latitude: 36.1166, longitude: -97.0584),
            CLLocation(latitude: 36.1136, longitude: -97.0784)
        ]
        
        for coor in coordninates{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coor.coordinate.latitude, longitude: coor.coordinate.longitude)
            
            let anno = MKPointAnnotation()
            anno.coordinate = CLLCoordType
            mapView.addAnnotation(anno)
        }
    }
    
    
    func setupLocationManager(){
        lM.delegate = self
        lM.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            locationManagerAuthorization(lM)
        }
        else{
            //Show Alert
        }
    }
    

    
    func locationManagerAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus{
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            break
        case .denied:
            //Show alert to switch on
            break
        case .notDetermined:
            lM.requestWhenInUseAuthorization()
            break
        case .restricted:
            //Show alert that location can not be used
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    
    func centerViewOnUserLocation(){
        
        if let location = lM.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
            mapView.setRegion(region, animated: true)
        }
    }

}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationServices()
    }
}
