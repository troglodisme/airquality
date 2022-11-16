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
    
    //AirQuality
    @StateObject var airQualityManager = AirQualityManager()
    @State var airQuality: Response?
    
    //Sheet
    @State private var showInformation = true
    
    
    var body: some View {
        
        ZStack{
            
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            
            VStack{
                
                if let location = locationManager.location {
                    
                    Text("Air Quality")
                    
                    
                        .task {
                            do {
                                airQuality = try await airQualityManager.getAirQuality(
                                    latitude: location.latitude,
                                    longitude: location.longitude
                                )
                            } catch {
                                print("ERROR: \(error)")
                            }
                        }
                    
                } else {
                    Text("Loading")
                }
                
            }
            .sheet(isPresented: $showInformation) {
                
                VStack{
                    Text("Air Quality")
                        .font(.title)
                    
                    if let airQuality = airQuality {

                        Text("Value: \(airQuality.data.indexes.baqi.aqiDisplay)")

                    }
                }

                
            .presentationDetents([.fraction(0.22), .fraction(0.5)])
            }

            
            
            
            
            
            //            if let location = locationManager.location {
            //
            //                Text(locationManager.location.debugDescription)
            //                    .foregroundColor(.white)
            //                    .background(Color.red)
            //
            //                    .task {
            //                        do {
            //                            airQuality = try await airQualityManager.getAirQuality(latitude: $locationManager.location?.latitude ?? default 50.0, longitude: $locationManager.location?.longitude ?? default 2.0)
            //                        } catch {
            //                            print("Error getting weather: \(error)")
            //                        }
            //                    }
            //
            //            }
            
            
            //            VStack {
            //                if let location = locationManager.location {
            //
            //                    Text(locationManager.location.debugDescription)
            //
            //                    if let airQuality = airQuality {
            //
            //                        AirQualityView(airQuality: airQuality)
            //
            //                    } else {
            //
            //                        Text("Loading...")
            //
            //                    }
            //                        LoadingView()
            //
            //
            //                    }
            
            ////                } else {
            ////                    if locationManager.isLoading {
            ////                        LoadingView()
            ////                    } else {
            ////                        WelcomeView()
            ////                            .environmentObject(locationManager)
            ////                    }
            //
            //                }
            //            }
            ////            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            //
            //
        }
        
        
        //        NavigationView {
        //
        //            ZStack{
        //
        ////                Map(coordinateRegion: $locationManager.region, showsUserLocation: showUserLocation)
        //
        //                VStack{
        //                    if let location = locationManager.location {
        //                        if let airQuality = airQuality {
        //                            AirQualityView(airQuality: airQuality)
        //                        }
        //                    }
        //                    else {
        //                        LoadingView()
        //                            .task {
        //                                do {
        //                                    airQuality = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
        //                                } catch {
        //                                    print("Error getting weather: \(error)")
        //                                }
        //                            }
        //                    }
        //                } else {
        //                    if locationManager.isLoading {
        //                        LoadingView()
        //                    } else {
        //                        WelcomeView()
        //                            .environmentObject(locationManager)
        //                    }
        //                }
        
        
        //
        //            }
        //
        ////            .ignoresSafeArea()
        //        }
        //        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        //        .preferredColorScheme(.dark)
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


