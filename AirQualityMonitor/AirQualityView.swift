//
//  AirQualityView.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

import SwiftUI
import Color

struct AirQualityView: View {
    
    @ObservedObject var locationManager: LocationManager
    
    //AirQuality
    @StateObject var airQualityManager = AirQualityManager()
    @State var airQualityResponse: Response?
    
    @State private var isShowingDetailView = false
    
    @Binding var selectedDetent: PresentationDetent
    
    
    var body: some View {
        
        NavigationView {
            
            
            VStack{
                
                VStack {
                    
                    if selectedDetent == .fraction(0.38) {
                        
                        //SMALL VIEW
                        VStack{
                            
                            //Response
                            HStack{
                                VStack{
                                    Text("\(airQualityManager.aqiDisplay)")
                                        .font(.system(size: 54, design: .rounded))
                                        .bold()
                                        .foregroundColor(Color(hex: airQualityManager.aqiColor))
                                    
                                    Text("AQI")
                                        .font(.system(.caption, design: .rounded))
                                        .bold()
                                        .foregroundColor(.gray)
                                        .offset(x: 40, y: -65)
                                }
                                
                                VStack{
                                    Text("\(airQualityManager.aqiCategory)")
                                        .font(.system(.body, design: .rounded))
                                        .bold()
                                        .foregroundColor(.white)
                                        .offset(y: 6)
   
                                }
                                Spacer()
                            }
                            .padding()

                            
                            //Recomandations
                            VStack{
                                Text(airQualityManager.aqiRecommendations)
//                                    .multilineTextAlignment(.center)
                                    .font(.system(.body, design: .rounded))
                                    .lineLimit(2...)
//                                    .offset(y: -20)

                            }
                            .padding()
                                
   
                        }
                        .background(Color("MedGray"))
                        .cornerRadius(10)
                        .padding()

                                            
                        
                    } else {
                        
                        //LARGE VIEW
                        VStack{
                            
                            VStack{
                                CurvedBar(airQualityManager: airQualityManager)
                                    .offset(y: 40)
                                
                                //Recomandations
                                VStack{
                                    
                                    Text(airQualityManager.aqiRecommendations)
//                                        .multilineTextAlignment(.center)
                                        .font(.system(.body, design: .rounded))
                                        .lineSpacing(4)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .offset(y:-10)
                                .padding()
                                
                            }
                            .background(Color("MedGray"))
                            .cornerRadius(10)
                            
                            
                            
                            //Main pollutant
                            VStack{
                                
                                HStack{
                                    
                                    Spacer()
                                    Text("Main pollutant today: \(airQualityManager.aqiPollutant.uppercased())")
                                        .font(.system(.body, design: .rounded))
                                    Spacer()
                                }
                                .padding()

                                
                                VStack{
                                    
                                    HStack{
                                        let pm2 = String(format: "%.f", airQualityManager.pm25Value) // "3.14"
                                        let pm10 = String(format: "%.f", airQualityManager.pm10Value) // "3.14"
                                        
                                        Text("PM2.5: \(pm2)")
                                            .font(.system(.body, design: .rounded))
                                            //add color scale
                                        
                                        Spacer()

                                        Text("PM10: \(pm10)")
                                            .font(.system(.body, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text("CO3: 48.2")
                                            .font(.system(.body, design: .rounded))
                                    }
                                }
                                .padding()
                                                                
                            }
                            .background(Color("MedGray"))
                            .cornerRadius(10)
                                                        
                        }
                        .padding()

                        
                    }



                    
                }
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            //end of main vstack
            
            
            //Can this go somewhere else?
            .task {
                do {
                    airQualityResponse = try await airQualityManager.getAirQuality(
                        latitude: locationManager.location!.latitude,
                        longitude: locationManager.location!.longitude
                    )
                } catch {
                    print("ERROR: \(error)")
                }
            }
            
            
            //            }
            
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    VStack(alignment: .leading) {
                        
                        Text(locationManager.city)
                            .font(.system(.title, design: .rounded))
                            .bold()
                            .offset(y:20)
                        //                            Text(locationManager.country)
                        //                                .font(.system(.subheadline, design: .rounded))
                        //                                .offset(y:20)
                        Text(locationManager.country)
                            .font(.system(.subheadline, design: .rounded))
                            .offset(y:20)
                        
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    
                    Button {
                        print("add to favourites")
                    } label: {
                        Image(systemName: "pin")
                    }
                }
                //end of navigation toolbar
                
            }
        }
    }
    

}

//
//    .onTapGesture(perform: simpleSuccess)
//
//func simpleSuccess() {
//    let generator = UINotificationFeedbackGenerator()
//    generator.notificationOccurred(.success)
//}


//                }


