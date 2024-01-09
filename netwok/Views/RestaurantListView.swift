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
            topRectangle()
            
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
                        Text("\(String(detailsViewModel.userCounts[building.id, default: 0]))")
                            .font(Font.custom("Manrope-SemiBold", size: 12))
                            .foregroundStyle(.black)
                    }
                    
                }
                .onTapGesture {
                    self.selectedBuildingId = building.id // Utilisez l'ID du bâtiment
                    self.detailsViewModel.loadBuildingDetails(id: building.id)
                    self.showingDetails = true
                }
                .onAppear {
                    detailsViewModel.loadUserCount(restaurantId: building.id)
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

private func topRectangle() -> some View {
    Rectangle()
        .frame(width: 60, height: 2)
        .foregroundColor(Color(red: 190/255, green: 190/255, blue: 190/255))
        .padding(.vertical, 10)
}
