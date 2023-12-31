//
//  ContentView.swift
//  netwok
//
//  Created by lebreuil thibault on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var showingRestaurantSheet = false
    @State private var selectedBuilding: Building?
    @State private var current_user = User(lastame: "Abc", firstname: "Def", company: "Google", job_title: "Developer", email: "abcdef@google.inc", building: "1", inside: false)
    
    var buildings: [Building] = [
        Building(id:"0", name: "Big Fernand", address: "5 Rue Guiraude, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3", latitude: 44.83978, longitude: -0.57524),
        Building(id:"1", name: "Restaurant le Saint Georges", address: "2 Pl. Camille Jullian, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83912, longitude: -0.57202),
        Building(id:"2", name: "L'Autre Petit Bois", address: "12 Pl. du Parlement, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84085, longitude: -0.57232),
        Building(id:"3", name: "Le Bocal de Tatie Josée", address: "71 rue des Trois-Conils, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83854, longitude: -0.57885),
        Building(id:"4", name: "Bioburger Bdx Gambetta", address: "12 Rue Georges Bonnac, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84027, longitude: -0.58181),
        // Add more buildings as needed
    ]
    
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
                        MapView(showingSheet: $showingSheet, selectedBuilding: $selectedBuilding)
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
                    if let building = selectedBuilding {
                        BuildingDetailsView(building: building)
                    }
                }
                .onChange(of: selectedBuilding) { _ in
                    if selectedBuilding != nil {
                        showingSheet = true
                    }
                }
                .sheet(isPresented: $showingRestaurantSheet) {
                    // Vue pour afficher les restaurants
                    RestaurantListView(buildings: buildings)
                }
            }
        }
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
