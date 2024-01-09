//
//  BuildingDetailsViewModel.swift
//  netwok
//
//  Created by Valentin Munch on 07.01.24.
//

import Foundation

class BuildingDetailsViewModel: ObservableObject {
    @Published var buildingDetails: Building?
    @Published var currentUser: User?
    @Published var usersInRestaurant: [User] = []
    @Published var userCounts: [Int: Int] = [:]
    let userId = 1643
    @Published var isLoading = false
    
    func loadCurrentUser() {
        guard let url = URL(string: "https://api-netwok.vercel.app/users/\(userId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self?.currentUser = decodedUser
                }
                
            } catch {
                print("Decoding user failed: \(error)")
            }
        }.resume()
    }
    
    
    
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
    
    
    
    func isUserInRestaurant(restaurantId: Int) -> Bool {
        return currentUser?.is_enter == true && currentUser?.restaurantId == restaurantId
    }
    
    
    func enterRestaurant(restaurantId: Int, userId: Int) {
        performRestaurantAction(endpoint: "/restaurants/\(restaurantId)/enter", userId: userId, isEntering: true, restaurantId: restaurantId) {
            // Update usersInRestaurant after successful entry
            if let currentUser = self.currentUser, !self.usersInRestaurant.contains(where: { $0.id == currentUser.id }) {
                self.usersInRestaurant.append(currentUser)
            }
        }
    }
    
    func exitRestaurant(restaurantId: Int, userId: Int) {
        performRestaurantAction(endpoint: "/restaurants/\(restaurantId)/exit", userId: userId, isEntering: false, restaurantId: restaurantId) {
            // Remove currentUser from usersInRestaurant after successful exit
            if let currentUser = self.currentUser {
                self.usersInRestaurant.removeAll(where: { $0.id == currentUser.id })
            }
        }
    }
    
    
    
    func performRestaurantAction(endpoint: String, userId: Int, isEntering: Bool, restaurantId: Int, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api-netwok.vercel.app\(endpoint)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Int] = ["userId": userId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error making request: \(error.localizedDescription)")
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)") // For debugging
                if httpResponse.statusCode != 200 {
                    DispatchQueue.main.async {
                        print("Error: Server returned status code \(httpResponse.statusCode)")
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                self?.currentUser?.is_enter = isEntering
                self?.currentUser?.restaurantId = isEntering ? restaurantId : nil
                completion() // Call completion handler after updating currentUser
            }
        }.resume()
    }
    
    
    
    
    func loadUsersInRestaurant(restaurantId: Int) {
        isLoading = true
        guard let url = URL(string: "https://api-netwok.vercel.app/restaurants/\(restaurantId)/users") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching users data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.usersInRestaurant = decodedUsers
                    self?.isLoading = false
                }
            } catch {
                print("Decoding users failed: \(error)")
            }
        }.resume()
    }
    
    struct UserCountResponse: Codable {
        var userCount: Int
    }
    
    
    func loadUserCount(restaurantId: Int) {
        guard let url = URL(string: "https://api-netwok.vercel.app/restaurants/\(restaurantId)/userCount") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching user count: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UserCountResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.userCounts[restaurantId] = decodedResponse.userCount
                }
            } catch {
                print("Decoding failed: \(error)")
            }        }.resume()
    }
    
}



