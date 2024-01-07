//
//  RestaurantListView.swift
//  netwok
//
//  Created by Valentin Munch on 31.12.23.
//

import SwiftUI

struct RestaurantListView: View {
    
    @ObservedObject var viewModel: BuildingViewModel
    @State private var selectedBuildingId: Int?
    @State private var showingDetails = false
    @StateObject private var detailsViewModel = BuildingDetailsViewModel()
    
    var body: some View {
        VStack{
            List(viewModel.buildings, id: \.id){building in
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
                    self.selectedBuildingId = building.id // Utilisez l'ID du bâtiment
                    self.detailsViewModel.loadBuildingDetails(id: building.id)
                    self.showingDetails = true
                }
            }
            .sheet(isPresented: $showingDetails) {
                if let buildingId = selectedBuildingId {
                    BuildingDetailsView(viewModel: detailsViewModel, buildingId: buildingId)
                }
            }
            .onChange(of: selectedBuildingId) { _ in
                if selectedBuildingId != nil {
                    showingDetails = true
                }
            }
        }
    }
}


struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        // Créez une instance de votre ViewModel avec des données de test
        let viewModel = BuildingViewModel()
        viewModel.buildings = [
            Building(id: 1, name: "Big Fernand", address: "5 Rue Guiraude, 33000 Bordeaux", latitude: 44.83978, longitude: -0.57524,image1: "image1", image2: "image2", image3: "image3"),
            // Ajoutez d'autres bâtiments de test si nécessaire
        ]
        
        // Prévisualisez votre RestaurantListView en utilisant le ViewModel de test
        return RestaurantListView(viewModel: viewModel)
    }
}
