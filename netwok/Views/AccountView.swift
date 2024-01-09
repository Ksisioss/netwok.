//
//  AccountView.swift
//  netwok
//
//  Created by Valentin Munch on 29.12.23.
//

import SwiftUI

struct AccountView: View {
    
    
    @State private var isEditing = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let userService = UserService.shared
    
    @State private var editableCompany: String = "Google"
    @State private var editableJobTitle: String = "Developer"
    @State private var editableEmail: String = "abcdef@google.inc"
    
    
    var body: some View {
        VStack {
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
                VStack(alignment: .leading) {
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
                
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        userService.updateUserProfile(company: editableCompany, jobTitle: editableJobTitle, email: editableEmail) { result in
                            switch result {
                            case .success(_):
                                alertMessage = "User profile updated successfully !"
                                showAlert = true
                            case .failure(let error):
                                alertMessage = "Failed to update profile: \(error.localizedDescription)"
                                showAlert = true
                            }
                        }
                    }
                    isEditing.toggle()
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
                    
                    TextField("Company", text: isEditing ? $editableCompany : .constant(userService.user.company))
                        .disabled(!isEditing)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                       

                }                .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: 325, height: 35)
                    .background(isEditing ? Color.green.opacity(0.2) : Color.clear)
                
                
                HStack {
                    Image(systemName: "suitcase.fill")
                        .foregroundColor(.black)
                        .frame(width: 16)
                    Spacer().frame(width: 20)
                    
                    TextField("Job Title", text: isEditing ? $editableJobTitle : .constant(userService.user.job_title))
                        .disabled(!isEditing)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                        

                }                .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: 325, height: 35)
                    .background(isEditing ? Color.green.opacity(0.2) : Color.clear)
                
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.black)
                        .frame(width: 16)
                    Spacer().frame(width: 20)
                    
                    TextField("Email", text: isEditing ? $editableEmail : .constant(userService.user.email))
                        .disabled(!isEditing)
                        .font(Font.custom("Manrope-SemiBold", size: 12))
                        

                }   .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .background(Color(red: 250/255, green: 250/255, blue: 250/255))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: 325, height: 35)
                    .background(isEditing ? Color.green.opacity(0.2) : Color.clear)
            }
            .padding(.vertical, 50)
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Update Profile"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
