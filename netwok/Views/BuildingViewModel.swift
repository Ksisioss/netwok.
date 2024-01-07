//
//  BuildingViewModel.swift
//  netwok
//
//  Created by Valentin Munch on 07.01.24.
//

import Foundation

import Foundation
import Combine

class BuildingViewModel: ObservableObject {
    @Published var buildings = [Building]()

    init() {
        loadBuildings()
    }

    func loadBuildings() {
        guard let url = URL(string: "https://api-netwok.vercel.app/restaurants") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([Building].self, from: data)
                DispatchQueue.main.async {
                    self.buildings = decodedResponse
                }
            } catch {
                print("Decoding failed: \(error)")
                // Pour voir plus de détails sur l'erreur, vous pouvez imprimer error.localizedDescription
                print("Error details: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    

}


