//
//  GeometryReader.swift
//  AirQualityMonitor
//
//  Created by Giulio on 23/11/22.
//

import SwiftUI

struct TestResizingCard: View {

    static let kMinHeight: CGFloat = 100.0
    @State var currentHeight: CGFloat = kMinHeight // << any initial

    var body: some View {
        GeometryReader { g in // << for top container height limit
            ZStack(alignment: .bottom) {
                Rectangle().fill(Color.yellow) // << just for demo
                
                self.card()
                .gesture(DragGesture()
                    .onChanged { value in
                        // as card is at bottom the offset is reversed
                        let newHeight = self.currentHeight - (value.location.y - value.startLocation.y)
                        if newHeight > Self.kMinHeight && newHeight < g.size.height {
                            self.currentHeight = newHeight
                        }
            })
            }
        }
    }

    func card() -> some View {
        ZStack(alignment: .top){
            RoundedRectangle(cornerRadius: 16.0)
                .frame(height:currentHeight)
                .padding()
            Text("Card")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.top)
        }
    }
}

struct TestResizingCard_Previews: PreviewProvider {
    static var previews: some View {
        TestResizingCard()
    }
}
