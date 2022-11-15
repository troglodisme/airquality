//
//  MapView.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

//Example of MapKit to understand how it works and how we can show a specific location

import MapKit
import SwiftUI
import CoreLocation
import CoreLocationUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(name: "Buckingham Palace",
             coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    
    Location(name: "Apple Developer Academy",
             coordinate: CLLocationCoordinate2D(latitude: 40.8367, longitude: 14.3066))
]

struct MapView: View {
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8518, longitude: 14.2681),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        //Width and height of the map view in degrees, namely the latitudeDelta and longitudeDelta.
    

    )

    var body: some View {

        NavigationView {
            
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            
            .navigationTitle("Air Quality")
            .ignoresSafeArea()
        }
        
//        Map(coordinateRegion: $mapRegion)
        
        
        
//        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//
//            MapMarker(coordinate: location.coordinate)
//
//        }
//        .ignoresSafeArea()
        
        
        
        
        

        
        
        

        
        

        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
