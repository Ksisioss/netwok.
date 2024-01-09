//
//  ContentView.swift
//  netwok
//
//  Created by lebreuil thibault on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingRestaurantSheet = false
    @State private var showingSheet = false
    @State private var selectedBuildingId: Int? // Utiliser un identifiant au lieu de l'objet Building
    @StateObject private var viewModel = BuildingViewModel()
    @StateObject private var detailsViewModel = BuildingDetailsViewModel()
    
    @State private var current_user = User(lastame: "Abc", firstname: "Def", company: "Google", job_title: "Developer", email: "abcdef@google.inc", building: "1", inside: false)
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                VStack(spacing: 2) {
                    Image(uiImage: UIImage(named: "appIconNoodlesWok")!)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("netwok.").bold().font(Font.custom("Manrope-SemiBold", size: 48))
                }
                Spacer()
                VStack {
                    
                    ZStack(alignment: .topLeading) {
                        MapView(
                            showingSheet: $showingSheet,
                            selectedBuildingId: $selectedBuildingId,
                            viewModel: viewModel,
                            onBuildingSelected: loadBuildingDetails
                        )
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .edgesIgnoringSafeArea(.all)
                        
                        // Bouton Paramètres
                        NavigationLink(destination: AccountView()) {
                            Image(systemName: "gear")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding()
                        .shadow(radius: 6, y: 4)
                        
                        // Bouton Carte pour Restaurants, aligné en haut à droite
                        HStack {
                            Spacer()
                            Button(action: {
                                showingRestaurantSheet = true
                            }) {
                                Image(systemName: "map")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .shadow(radius: 6, y: 4)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                    }
                    
                }
                .sheet(isPresented: $showingSheet) {
                    if let buildingId = selectedBuildingId {
                        BuildingDetailsView(viewModel: detailsViewModel, buildingId: buildingId)
                    }
                }
                .onChange(of: selectedBuildingId) { _ in
                    if selectedBuildingId != nil {
                        showingSheet = true
                    }
                }
                .sheet(isPresented: $showingRestaurantSheet) {
                    // Vue pour afficher les restaurants
                    RestaurantListView(viewModel: viewModel)
                }
            }
        }
    }
    
    
    private func loadBuildingDetails(buildingId: Int) {
        detailsViewModel.loadBuildingDetails(id: buildingId)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// Forme personnalisée pour les coins arrondis spécifiques
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
