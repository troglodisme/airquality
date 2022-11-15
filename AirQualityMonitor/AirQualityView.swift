//
//  AirQualityView.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

import SwiftUI

struct AirQualityView: View {
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                HStack{
                    
                    Text("Air Quality")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    Image(systemName: "gear")
                    Image(systemName: "aqi.low")

                }
                .padding()
                
                Spacer()
                
            }
            .background(Color.gray)


            
        
//          .navigationTitle("Air Quality")
//          .toolbar {
//              Button("Help") {
//                  print("Help tapped!")
//              }
//          }
            
        }

        
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView()
    }
}
