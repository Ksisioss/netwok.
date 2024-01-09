//
//  UserViewModel.swift
//  netwok
//
//  Created by Valentin Munch on 09.01.24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = [] // Liste des utilisateurs filtrés affichés
    private var allUsers: [User] = [] // Liste complète des utilisateurs
    @Published var searchText: String = "" // Texte de recherche

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadAllUsers()

        // Réagir aux changements dans searchText
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] in self?.filterUsers(searchText: $0) }
            .store(in: &cancellables)
    }

    func loadAllUsers() {
        // Chargement de la liste complète des utilisateurs
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
                    self?.allUsers = users
                    self?.filterUsers(searchText: self?.searchText ?? "")
                }
            } catch {
                print("Decoding users failed: \(error)")
            }
        }.resume()
    }

    private func filterUsers(searchText: String) {
        DispatchQueue.main.async {
            if searchText.isEmpty {
                self.users = self.allUsers
            } else {
                self.users = self.allUsers.filter { user in
                    user.firstname.localizedCaseInsensitiveContains(searchText) ||
                    user.lastname.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
}

