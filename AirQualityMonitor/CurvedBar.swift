import SwiftUI

//stolen from https://github.com/al100/SwiftPartialCircularProgressBar

struct CurvedBar: View {
    
    @ObservedObject var airQualityManager: AirQualityManager

    @State var progressValue: Float = 0.1
    
    let timer = Timer
        .publish(every: 0.01, on: .main, in: .common)
        .autoconnect()
    
    @State private var degress: Double = -100    
    
    @State private var aqi = 0
    
    var body: some View {
                
        
//        VStack {
            
            ZStack{
                
                ProgressBar(progress: self.$progressValue, airQualityManager: airQualityManager)
                    .frame(width: 240.0, height: 240.0)
                    .padding(10.0)
                    .onReceive(timer) { _ in

                        withAnimation {

                            if progressValue < 0.65 {
                                progressValue += 0.01  //increment progress value
                            }
                        }
                    }
                
//                ProgressBarTriangle(progress: self.$progressValue).frame(width: 280.0, height: 280.0)
//                    .rotationEffect(.degrees(degress), anchor: .bottom)
//                    .offset(x: 0, y: -150)
//                    .onReceive(timer) { input in
//                        withAnimation(.linear(duration: 0.01).speed(200)) {
//                            if degress < 100 {
//                                degress += 5
//                            }
//                            print(degress)
//                        }
//                    }
            }
            
        }
//        Spacer()

//    }
    
    struct ProgressBar: View {
        @Binding var progress: Float
        
        @ObservedObject var airQualityManager: AirQualityManager
        
        var body: some View {
            
            ZStack {
                Circle()
                    .trim(from: 0.3, to: 0.9)
                    .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                    .rotationEffect(.degrees(54.5))
                
                
                Circle()
//                    .trim(from: 0.3, to: CGFloat(airQualityManager.aqiValueMapped))

                    .trim(from: 0.3, to: CGFloat(self.progress))
                    .stroke(style: StrokeStyle(lineWidth: 14.0, lineCap: .round, lineJoin: .round))
                    .fill(AngularGradient(gradient: Gradient(stops: [
                        .init(color: Color.init(hex: "730006"), location: 0.3),
                        .init(color: Color.init(hex: "FB0015"), location: 0.40),
                        .init(color: Color.init(hex: "FFFD2D"), location: 0.57),
                        .init(color: Color.init(hex: "7EC737"), location: 0.75),
                        .init(color: Color.init(hex: "1E9337"), location: 0.8)
                    ]
                    ), center: .center)
                    )
                    .rotationEffect(.degrees(54.5))
                
                VStack{

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

                    Text("\(airQualityManager.aqiCategory)")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .offset(y: -20)

                }
                
            }
        }
    }
    
    struct ProgressBarTriangle: View {
        @Binding var progress: Float        
        
        var body: some View {
            ZStack {
                Image("triangle")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
            }
        }
    }
}

struct CurvedBar_Previews: PreviewProvider {
    static var previews: some View {
        CurvedBar(airQualityManager: AirQualityManager())
    }
}

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



//struct AnimatingNumberView: View {
//
//    // Change 1: number is now a Double
//    @State private var number: Double = 0
//
//    var body: some View {
//        VStack(spacing: 20) {
//            // Change 2: we have a container with our modifier applied
//            Color.clear
//                .frame(width: 50, height: 50)
//                .animatingOverlay(for: number)
//
//            Button {
//                withAnimation {
//                    number = .random(in: 0 ..< 200)
//                }
//            } label: {
//                Text("Create random number")
//            }
//        }
//    }
//}
