////
////  Model.swift
////  AirQualityMonitor
////
////  Created by Giulio on 14/11/22.
////
//
//import Foundation
//import CoreLocation
//
//class AirQualityManager {
//    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
//    func getAirQuality(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> AirQualityInfo {
//        // Replace YOUR_API_KEY in the link below with your own
//        guard let url = URL(string: "https://api.breezometer.com/air-quality/v2/current-conditions?lat=\(latitude)&lon=\(longitude)&key=65bc6c1ee49648b8acc79ceeddc4130a") else { fatalError("Missing URL") }
//
//        let urlRequest = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
//
//        let decodedData = try JSONDecoder().decode(AirQualityInfo.self, from: data)
//
//        return decodedData
//    }
//}
//
//
//struct AirQualityInfo: Decodable {
//    let data: DataStruct
//}
//
//struct DataStruct: Decodable {
//    let datetime: Date
//    let dataAvailable: Bool
//    let indexes: Indexes
//}
//
//struct Indexes: Decodable {
//    let baqi: Baqi
//}
//
//struct Baqi: Decodable {
//    let displayName: String
//    let aqi: String
//    let aqiDisplay: String
//    let color: String
//    let category: String
//    let dominantPollutant: String
//
//}
//
//
