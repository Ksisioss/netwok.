//
//  RestaurantListView.swift
//  netwok
//
//  Created by Valentin Munch on 31.12.23.
//

import SwiftUI

struct RestaurantListView: View {
    
    var buildings: [Building]
    @State private var selectedBuilding: Building?
    @State private var showingDetails = false
    
    var body: some View {
        VStack{
            List(buildings, id: \.id){building in
                VStack(alignment: .leading){
                    Text(building.name)
                        .font(Font.custom("Manrope-SemiBold", size: 20))
                    
                    Text(building.address)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                        .foregroundStyle(.secondary)
                    
                    HStack{
                        Image(systemName: "person.fill")
                            .foregroundColor(.black)
                            .frame(width: 12)
                        
                        // Changer avec le compte d'utilisateurs dans chaque resto
                        Text("13")
                            .font(Font.custom("Manrope-SemiBold", size: 12))
                            .foregroundStyle(.black)
                    }
                    
                }
                .onTapGesture {
                    self.selectedBuilding = building
                    self.showingDetails = true
                }
            }
            .sheet(isPresented: $showingDetails) {
                if let building = selectedBuilding {
                    BuildingDetailsView(building: building)
                }
            }
            .onChange(of: selectedBuilding) { _ in
                if selectedBuilding != nil {
                    showingDetails = true
                }
            }
        }
    }
}

var buildings: [Building] = [
    Building(id:"0", name: "Big Fernand", address: "5 Rue Guiraude, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3", latitude: 44.83978, longitude: -0.57524),
    Building(id:"1", name: "Restaurant le Saint Georges", address: "2 Pl. Camille Jullian, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83912, longitude: -0.57202),
    Building(id:"2", name: "L'Autre Petit Bois", address: "12 Pl. du Parlement, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84085, longitude: -0.57232),
    Building(id:"3", name: "Le Bocal de Tatie Josée", address: "71 rue des Trois-Conils, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.83854, longitude: -0.57885),
    Building(id:"4", name: "Bioburger Bdx Gambetta", address: "12 Rue Georges Bonnac, 33000 Bordeaux", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3",latitude: 44.84027, longitude: -0.58181),
    // Add more buildings as needed
]

#Preview {
    RestaurantListView(buildings: buildings)
}
