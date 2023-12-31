//
//  AccountView.swift
//  netwok
//
//  Created by Valentin Munch on 29.12.23.
//

import SwiftUI

struct AccountView: View {
    @State private var input1: String = ""
    @State private var input2: String = ""
    @State private var input3: String = ""
    
    var body: some View {
        VStack{
            VStack(spacing: 5) {
                Image(uiImage: UIImage(named: "appIconNoodlesWok")!)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("netwok.").bold().font(Font.custom("Manrope-SemiBold", size: 48))
            }
            HStack(spacing: 0) {
                Text("Hello ")
                Text("Valentin").bold()
                Text(" !")
            }
            .font(Font.custom("Manrope-Regular", size: 14))
            .padding(.bottom, 25)
            .padding(.top, 2)
            
            HStack{
                Image(uiImage: UIImage(named: "pfp")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 62, height: 62)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    HStack(spacing: 0) {
                        Text("Firstname : ")
                        Text("Valentin").bold()
                    }
                    .font(Font.custom("Manrope-Regular", size: 14))
                    
                    HStack(spacing: 0) {
                        Text("Lastname : ")
                        Text("Munch").bold()
                    }
                    .font(Font.custom("Manrope-Regular", size: 14))
                }
                .padding(.horizontal, 5)
                Button("Edit"){
                    
                }
                .font(.custom("Manrope-Medium", size: 13))
                .foregroundColor(.black)
                .frame(width: 73, height: 23)
                .buttonStyle(ThreeDButtonStyle(fillColor: Color(red: 245/255, green: 245/255, blue: 245/255)))
                
            }
            VStack{
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.black)
                        .frame(width: 16)
                    Spacer().frame(width: 20)
                    TextField("company", text: $input1)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(width: 325, height: 35)
                
                HStack {
                    Image(systemName: "suitcase.fill")
                        .foregroundColor(.black)
                        .frame(width: 16)
                    Spacer().frame(width: 20)
                    TextField("job title", text: $input2)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(width: 325, height: 35)
                
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.black)
                        .frame(width: 16)
                    Spacer().frame(width: 20)

                    TextField("email", text: $input3)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(width: 325, height: 35)
                

            }
            .padding(.vertical, 50)
            Spacer()
        }
    }
}

#Preview {
    AccountView()
}
