//
//  BuildingDetailsView.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import SwiftUI

struct BuildingDetailsView: View {
    @ObservedObject var viewModel: BuildingDetailsViewModel
    
    @State private var isButtonPressed = false
    @State private var showModal = false
    @State private var selectedImage: UIImage?
    @State private var selectedUser: User?
    
    var buildingId: Int
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                // Afficher une animation de chargement
                ProgressView()
            } else if let building = viewModel.buildingDetails {
                // Afficher le contenu des détails du bâtiment
                buildingDetailsContent(building)
            } else {
                // Afficher un message si les détails ne sont pas chargés
                Text("Impossible de charger les détails.")
            }
        }
        .onAppear {
            viewModel.loadBuildingDetails(id: buildingId)
            viewModel.loadUsersInRestaurant(restaurantId: buildingId)
            viewModel.loadCurrentUser()
        }
        .onDisappear {
            viewModel.isLoading = false
        }
        .fullScreenCover(item: $selectedUser) { user in
                UserDetailsView(user: user)
        }
    }
    
    
    private func buildingDetailsContent(_ building: Building) -> some View {
        VStack {
            topRectangle()
            
            buildingInfo(building)
            
            imageSection(building)
            
            userSection()
            
            joinButton(restaurantId: building.id)
            
            Spacer()
        }.overlay(
            showModal && selectedImage != nil ?
            ImageViewer(image: selectedImage!, showModal: $showModal)
            : nil
        )
    }
    
    private func topRectangle() -> some View {
        Rectangle()
            .frame(width: 60, height: 2)
            .foregroundColor(Color(red: 190/255, green: 190/255, blue: 190/255))
            .padding(.vertical, 10)
    }
    
    private func buildingInfo(_ building: Building) -> some View {
        VStack(alignment: .leading){
            Text(building.name)
                .font(Font.custom("Manrope-SemiBold", size: 24))
                .bold()
            
            Text(building.address)
                .font(Font.custom("Manrope-SemiBold", size: 14))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
        .padding(.leading, 75)
    }
    
    private func imageSection(_ building: Building) -> some View {
        HStack(alignment: .top) {
            ZStack {
                Rectangle()
                    .fill(Color.gray) // Couleur grise pour le rectangle
                    .frame(width: 120, height: 120) // Taille du rectangle
                    .cornerRadius(10) // Arrondi des coins pour le rectangle
                
                Image(building.image1)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // L'image remplit le cadre
                    .frame(width: 120, height: 120) // Taille de l'image identique au rectangle
                    .cornerRadius(10) // Arrondi des coins pour l'image
                    .clipped() // Coupe l'excès d'image
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.selectedImage = UIImage(named: building.image1)
                            self.showModal = true
                        }
                    }
            }
            .clipped()
            
            VStack {
                if let image2 = UIImage(named: building.image2) {
                    Image(uiImage: image2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 55)
                        .cornerRadius(10)
                        .clipped()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.selectedImage = image2
                                self.showModal = true
                            }
                        }
                } else {
                    Text("Image not found")
                        .font(Font.custom("Manrope-SemiBold", size: 18))
                }
                
                if let image3 = UIImage(named: building.image3) {
                    Image(uiImage: image3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 55)
                        .cornerRadius(10)
                        .clipped()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.selectedImage = image3
                                self.showModal = true
                            }
                        }
                } else {
                    Text("Image not found")
                        .font(Font.custom("Manrope-SemiBold", size: 18))
                }
            }
        }
    }
    
    private func userSection() -> some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Personnes présentes")
                    .font(Font.custom("Manrope-SemiBold", size: 16))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.usersInRestaurant, id: \.id) { user in
                        VStack {
                            Image(uiImage: UIImage(named: user.avatar_url) ?? UIImage(named: "defaultAvatar")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 62, height: 62)
                                .clipShape(Circle())
                            Text(user.firstname)
                                .font(Font.custom("Manrope-SemiBold", size: 14))
                            Text(user.company)
                                .font(Font.custom("manrope", size: 12))
                                .foregroundColor(.secondary)
                        }.onTapGesture {
                            self.selectedUser = user
                        }
                    }
                }
                .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
            }
            .frame(height: 125)
            .transition(.move(edge: .bottom))
        }
        .padding(.horizontal, 75)
    }
    
    
    private func joinButton(restaurantId: Int) -> some View {
        let userId = 338 // ID utilisateur fixé
        
        return Button(viewModel.isUserInRestaurant(restaurantId: restaurantId) ? "Leave" : "Join") {
            if viewModel.isUserInRestaurant(restaurantId: restaurantId) {
                viewModel.exitRestaurant(restaurantId: restaurantId, userId: userId)
            } else {
                viewModel.enterRestaurant(restaurantId: restaurantId, userId: userId)
            }
        }
        .font(.custom("Manrope-Medium", size: 13))
        .foregroundColor(.black)
        .frame(width: 73, height: 23)
        .buttonStyle(ThreeDButtonStyle(fillColor: viewModel.isUserInRestaurant(restaurantId: restaurantId) ? Color(red: 255/255, green: 236/255, blue: 236/255) : Color(red: 233/255, green: 255/255, blue: 235/255)))
        .padding(.top, 25)
    }
}
