////
////  ContentView.swift
////  AirQualityMonitor
////
////  Created by Giulio on 14/11/22.
////
//
//import SwiftUI
//
//
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//
//struct ContentView: View {
//    
//    @State private var results = [Result]()
//    
//    var body: some View {
//        
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading){
//                Text(item.trackName)
//                    .font(.headline)
//                
//                Text(item.collectionName)
//            }
//            
//        }
//
//        .task {
//            await loadData()
//            // ??
//        }
//        
//    }
//    
//    
//    func loadData() async {
//        
//        //Step 1
//        guard let url = URL(string: "https://itunes.apple.com/search?term=toomuchblond&entity=song")
//        //if that fails
//        else {
//            print("Invalid URL")
//            return
//        }
//        
//        
//        //Step 2: fetch data from URL
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//            
//        } catch {
//            print("Invalid data")
//        }
//        
//    }
//}
//
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//
////65bc6c1ee49648b8acc79ceeddc4130a
////
////https://api.breezometer.com/air-quality/v2/current-conditions?lat={latitude}&lon={longitude}&key=YOUR_API_KEY&features={Features_List}
////
//
//
