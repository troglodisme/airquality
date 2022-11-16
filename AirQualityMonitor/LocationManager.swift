//
//  LocationManager.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

//https://codewithchris.com/swiftui/swiftui-corelocation/


import Foundation
import CoreLocation
import MapKit

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    // Creating an instance of CLLocationManager, the framework we use to get the coordinates
//    let manager = CLLocationManager()
//
//    @Published var location: CLLocationCoordinate2D?
//    @Published var isLoading = false
//
//    override init() {
//        super.init()
//
//        // Assigning a delegate to our CLLocationManager instance
//        manager.delegate = self
//    }
//
//    // Requests the one-time delivery of the user’s current location, see https://developer.apple.com/documentation/corelocation/cllocationmanager/1620548-requestlocation
//    func requestLocation() {
//        isLoading = true
//        manager.requestLocation()
//    }
//
//    // Set the location coordinates to the location variable
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//        isLoading = false
//    }
//
//
//    // This function will be called if we run into an error
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error getting location", error)
//        isLoading = false
//    }
//}



//Use to display map

class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject {

    private let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()

    @Published var isLoading = false

    override init() {
            super.init()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        location = locations.first?.coordinate
        
            locations.last.map {

                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),

                    span: MKCoordinateSpan(latitudeDelta: 0.2,
                                           longitudeDelta: 0.2)
                )
            }
        }
    
    
    //    // Set the location coordinates to the location variable
        
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        location = locations.first?.coordinate
    //        isLoading = false
    //    }
    
    // Requests the one-time delivery of the user’s current location, see https://developer.apple.com/documentation/corelocation/cllocationmanager/1620548-requestlocation
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }



    // This function will be called if we run into an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
    

}
