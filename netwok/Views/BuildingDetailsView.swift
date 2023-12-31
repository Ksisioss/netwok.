//
//  BuildingDetailsView.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import SwiftUI

struct BuildingDetailsView: View {
    var building: Building
    @State private var isButtonPressed = false
    
    
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(width: 60, height: 2)
                .foregroundColor(Color(red: 190/255, green: 190/255, blue: 190/255))
                .padding(.vertical, 10)
            
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
                }
                .clipped()
                
                VStack {
                    Image(uiImage: UIImage(named: building.image2)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 55)
                        .cornerRadius(10)
                        .clipped()
                    
                    Image(uiImage: UIImage(named: building.image3)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 55)
                        .cornerRadius(10)
                        .clipped()
                    
                }
            }
            
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
            
            Button(isButtonPressed ? "Left" : "Join") {
                isButtonPressed.toggle()
            }
            .font(.custom("Manrope-Medium", size: 13))
            .foregroundColor(.black)
            .frame(width: 73, height: 23)
            .buttonStyle(ThreeDButtonStyle(fillColor: isButtonPressed ? Color(red: 255/255, green: 236/255, blue: 236/255) : Color(red: 233/255, green: 255/255, blue: 235/255)))
            .padding(.top, 25)
            
            
            Spacer()
            
            // Inutile
            //            Button("Close") {
            //                // Fermez la feuille ou effectuez toute autre action
            //            }
        }
        
        
    }
}

struct BuildingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingDetailsView(building: Building(id:"0", name: "Building 1", address: "25 rue des Champs, 33002 BORDEAUX", image1: "autre-petit-bois-p1", image2: "autre-petit-bois-p2", image3:"autre-petit-bois-p3", latitude: 44.83558, longitude: -0.57179))
    }
}
