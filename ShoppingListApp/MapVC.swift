//
//  MapVC.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLocatonManager()
        
    }
    
    private func setupLocatonManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Location Manager func
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        updateMapRegion(to: location.coordinate)
        
    }
    
    private func updateMapRegion(to coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func startLocationUpdates(){
        locationManager.startUpdatingLocation()
        
        //Zoom to user location if available
        if let userLocation = locationManager.location?.coordinate{
            updateMapRegion(to: userLocation)
        }
    }
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        case .denied, .restricted, .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    // MARK: CLLocationManagerDelegate
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus(manager.authorizationStatus)
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
