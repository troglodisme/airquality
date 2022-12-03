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


final class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject {

    private let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()

    @Published var isLoading = false

    //Publish city location
    @Published var street = ""
    @Published var city = ""
    @Published var country = ""

    //add is favourite parameter to store saved locations in array

    override init() {
            super.init()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
        
        
        //        location = locations.first?.coordinate
        //
        //            locations.last.map {
        //                region = MKCoordinateRegion(
        //                    center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
        //                    span: MKCoordinateSpan(latitudeDelta: 0.2,
        //                                           longitudeDelta: 0.2)
        //                )
        //            }
        

        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                guard let placeMark = placemarks?.first else { return }

                if let locationName = placeMark.location {
//                    print("coordinates: \(locationName)")
                }
            
                if let street = placeMark.thoroughfare {
                    self.street = street
                }
            
                if let city = placeMark.subAdministrativeArea {
                    self.city = city
                }
            
                if let zip = placeMark.isoCountryCode {
                }
            
                if let country = placeMark.country {
                    self.country = country

                }
        })
        
        
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
