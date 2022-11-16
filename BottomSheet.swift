//
//  BottomSheet.swift
//  AirQualityMonitor
//
//  Created by Giulio on 15/11/22.
//

import SwiftUI

    
struct BottomSheet: View {
        @State private var showingCredits = true

        var body: some View {
            
            Button("Show Credits") {
                
                showingCredits.toggle()
            }
            
            .sheet(isPresented: $showingCredits) {
                
                Text("This app was brought to you by Hacking with Swift")
                    .presentationDetents([.fraction(0.3), .fraction(0.5)])
                
            }
        }
}
    
struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
