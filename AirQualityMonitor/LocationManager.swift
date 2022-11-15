//
//  LocationManager.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

//https://codewithchris.com/swiftui/swiftui-corelocation/


import Foundation
import MapKit
import CoreLocation


class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject {

    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    
    override init() {
            super.init()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            locations.last.map {
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude,
                                                   longitude: $0.coordinate.longitude),
                    
                    span: MKCoordinateSpan(latitudeDelta: 0.2,
                                           longitudeDelta: 0.2)
                )
                
                
            }
        }
    
}
