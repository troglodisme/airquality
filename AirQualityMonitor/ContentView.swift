//
//  ContentView.swift
//  AirQualityMonitor
//
//  Created by Giulio on 14/11/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct ContentView: View {
    
    //Map
    @StateObject var locationManager = LocationManager()
    @State var tracking:MapUserTrackingMode = .none
    @State private var showUserLocation = false

    //Sheet
    @State private var showInformation = true
    

    
    var body: some View {
        
        
        
        NavigationView {
            
            ZStack{
                
                Map(coordinateRegion: $locationManager.region, showsUserLocation: showUserLocation)
                
                Button("Show Info") {
                    showInformation.toggle()
                }
                
                    .sheet(isPresented: $showInformation) {
                        
                        AirQualityView()
                            .presentationDetents([.fraction(0.22), .fraction(0.5)])

                    }
                
            }
            
//            .navigationTitle("Air Quality")
            .ignoresSafeArea()
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


