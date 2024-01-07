//
//  BuildingDetailsViewModel.swift
//  netwok
//
//  Created by Valentin Munch on 07.01.24.
//

import Foundation

class BuildingDetailsViewModel: ObservableObject {
    @Published var buildingDetails: Building?

    func loadBuildingDetails(id: Int) {
        guard let url = URL(string: "https://api-netwok.vercel.app/restaurants/\(id)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(Building.self, from: data)
                DispatchQueue.main.async {
                    self?.buildingDetails = decodedResponse
                }
            } catch {
                print("Decoding failed: \(error)")
            }
        }.resume()
    }
}

