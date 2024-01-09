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
    
    var buildingId: Int
    
    var body: some View {
        VStack {
            if let building = viewModel.buildingDetails {
                buildingDetailsContent(building)
            } else {
                // Afficher un indicateur de chargement ou un message si les données ne sont pas encore chargées
                Text("Chargement des détails...")
            }
        }
        .onAppear {
            viewModel.loadBuildingDetails(id: buildingId)
        }
    }
    
    
    private func buildingDetailsContent(_ building: Building) -> some View {
        VStack {
            topRectangle()
            
            buildingInfo(building)
            
            imageSection(building)
            
            userSection()
            
            joinButton()
            
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
                
                Image(uiImage: UIImage(named: building.image2)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 55)
                    .cornerRadius(10)
                    .clipped()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.selectedImage = UIImage(named: building.image1)
                            self.showModal = true
                        }
                    }
                
                Image(uiImage: UIImage(named: building.image3)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 55)
                    .cornerRadius(10)
                    .clipped()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.selectedImage = UIImage(named: building.image1)
                            self.showModal = true
                        }
                    }
                
            }
            
        }
    }
    
    private func userSection() -> some View {
        VStack(alignment: .leading){
            VStack{
                Text("Personnes présentes")
                    .font(Font.custom("Manrope-SemiBold", size: 16))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5, id: \.self) { _ in
                        VStack {
                            Image(uiImage: UIImage(named: "pfp")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 62, height: 62)
                                .clipShape(Circle())
                            Text("A.Peko")
                                .font(Font.custom("Manrope-SemiBold", size: 14))
                            Text("Google")
                                .font(Font.custom("manrope", size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                }
                .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
            }
            .frame(height: 125)
            .transition(.move(edge: .bottom))
        }.padding(.horizontal, 75)
    }
    
    private func joinButton() -> some View {
        Button(isButtonPressed ? "Left" : "Join") {
            isButtonPressed.toggle()
        }
        .font(.custom("Manrope-Medium", size: 13))
        .foregroundColor(.black)
        .frame(width: 73, height: 23)
        .buttonStyle(ThreeDButtonStyle(fillColor: isButtonPressed ? Color(red: 255/255, green: 236/255, blue: 236/255) : Color(red: 233/255, green: 255/255, blue: 235/255)))
        .padding(.top, 25)
    }
    
}
