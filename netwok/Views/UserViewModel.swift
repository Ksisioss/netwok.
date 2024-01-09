//
//  UserViewModel.swift
//  netwok
//
//  Created by Valentin Munch on 09.01.24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = [] // Liste de tous les utilisateurs
    @Published var searchText: String = ""
    @Published var filter: String = "All"
//    @State private var selectedUser: User?


    private var cancellables = Set<AnyCancellable>()

    init() {
        loadAllUsers()

        // Filtrer les utilisateurs en fonction de searchText et filter
        $searchText
            .combineLatest($filter)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { [weak self] searchText, filter in
                self?.filterUsers(searchText: searchText, filter: filter) ?? []
            }
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }


    func loadAllUsers() {
        guard let url = URL(string: "https://api-netwok.vercel.app/users") else {
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
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            } catch {
                print("Decoding users failed: \(error)")
            }
        }.resume()
    }

    private func filterUsers(searchText: String, filter: String) -> [User] {
            users.filter { user in
                let matchesSearchText = searchText.isEmpty || user.firstname.localizedCaseInsensitiveContains(searchText) || user.lastname.localizedCaseInsensitiveContains(searchText)
                let matchesFilter = filter == "All" || (filter == "Company" && user.company == searchText) || (filter == "Job Title" && user.job_title == searchText)
                
                return matchesSearchText && matchesFilter
            }
        }
}
