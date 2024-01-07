//
//  RestaurantService.swift
//  netwok
//
//  Created by Valentin Munch on 07.01.24.
//

import Foundation

//class RestaurantData: ObservableObject {
//    @Published var restaurants: [Building] = []
//}
//
//struct RestaurantService {
//    func loadRestaurants(completion: @escaping ([Building]) -> Void) {
//        guard let url = URL(string: "https://api-netwok.vercel.app/restaurants/") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            var restaurants: [Building] = []
//
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode([Building].self, from: data) {
//                    restaurants = decodedResponse
//                }
//            } else {
//                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//            }
//
//            DispatchQueue.main.async {
//                completion(restaurants)
//            }
//        }.resume()
//    }
//}
