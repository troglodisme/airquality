//
//  ContentView.swift
//  AirQualityMonitor
//
//  Created by Giulio on 22/11/22.


import SwiftUI
import CoreLocationUI
import MapKit

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


struct ContentView: View {

    //Map
    @StateObject var locationManager = LocationManager()
    @State var tracking:MapUserTrackingMode = .follow
    @State var detent: PresentationDetent = .fraction(0.38)
    
    //Sheet
    @State private var showInformation = true

    var body: some View {

        ZStack{

            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true
            )
            .ignoresSafeArea()
            
//            Map(coordinateRegion: $locationManager.region, annotationItems: locations) { location in
//
//                MapAnnotation(coordinate: location.coordinate) {
//
//                    NavigationLink {
//                        Text(location.name)
//
//                    } label: {
//                        Circle()
//                            .stroke(.red, lineWidth: 3)
//                            .frame(width: 44, height: 44)
//                    }
//
//                }
//            }

            //top right button
            
//            VStack {
//                HStack {
//                    Spacer()
//
//                    VStack {
//
//                        Button(action: {
//                            print("test top button")
//                        }, label: {
//                            Image(systemName: "gear")
//                                .padding()
//                        })
//                    }
//                    .background {
//                        RoundedRectangle(cornerRadius: 8)
//                            .tint(Color.gray)
//                    }
//                    .padding(10)
//
//                }
//                Spacer()
//            }
            
            //end of top right button

        }
        .sheet(isPresented: $showInformation) {

            AirQualityView(locationManager: locationManager, selectedDetent: $detent)
//                .presentationDetents([.fraction(0.40), .fraction(0.80)])
                .presentationDetents([.fraction(0.38), .fraction(0.93)], selection: $detent)
                .interactiveDismissDisabled(true)

        }


    }
    

    

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

