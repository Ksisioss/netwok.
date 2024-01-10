import SwiftUI

struct UserDetailsView: View {
    var user: User
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    avatar
                    restaurantPinIndicator()
                        .offset(x: 111, y: -130)
                    greeting
                    VStack(alignment: .center) {
                        informationGrid
                    }
                    
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true) // Cacher le bouton "Back"
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                backButton
            })
        }
    }
    
    
    var backButton: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
            .padding()
            Spacer()
        }
    }
    
    var avatar: some View {
        Image(uiImage: UIImage(named: user.avatar_url) ?? UIImage(named: "defaultAvatar")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 110, height: 110)
            .clipShape(Circle())
            .padding()
    }
    
    @ViewBuilder
    private func restaurantPinIndicator() -> some View {
        if user.is_enter {
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .background(Circle().fill(Color.green).frame(width: 50, height: 50))
        } else {
            Image(systemName: "mappin.slash")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .background(Circle().fill(Color.red).frame(width: 50, height: 50))
        }
    }
    
    
    var greeting: some View {
        Text("Hi, I'm \(user.firstname) \(user.lastname)")
            .font(.custom("Manrope-Bold", size: 28))
            .fontWeight(.bold)
            .offset(x: 35, y: -60)
            .padding(.trailing, 50)
    }
    
    var informationGrid: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    detailItem(title: "Company", value: user.company, iconName: "building.2")
                    detailItem(title: "Email", value: user.email, isEmail: true, iconName: "envelope")
                }
                .padding(.trailing, 17)
                
                VStack(alignment: .leading, spacing: 20) {
                    detailItem(title: "Job Title", value: user.job_title, iconName: "briefcase")
                    if user.is_enter {
                        detailItem(title: "Restaurant", value: user.restaurant_name, iconName: "fork.knife")
                    }
                }
                .padding(.leading, 17)
            }
        }
        .padding(.horizontal)
        .padding(.top, -40)
    }
    
    
    func detailItem(title: String, value: String, isEmail: Bool = false, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("Manrope-Bold", size: 18))
                    .fontWeight(.bold)
                
                if isEmail {
                    Button(action: {
                        // Action to open the mail application
                        openMail(email: value)
                    }) {
                        Text(value)
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .foregroundColor(.blue) // Make the text blue
                            .underline() // Underline the text
                    }
                } else {
                    Text(value)
                        .font(.system(size: 15))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    
    private func openMail(email: String) {
        if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    struct UserDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            UserDetailsView(user: User(id: 1, firstname: "First", lastname: "Last", company: "Acme Inc", job_title: "Developer", email: "email@example.com", restaurant_name: "The Great Eatery", is_enter: true, avatar_url: "defaultAvatar", restaurantId: nil))
        }
    }
}
