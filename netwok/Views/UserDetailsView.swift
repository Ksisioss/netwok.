import SwiftUI

struct UserDetailsView: View {
    var user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // The Spacer here pushes the HStack to the top of the VStack
            Spacer()
                .frame(height: 44) // Typically, the height of the navigation bar area
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left") // System name for left arrow icon
                        .imageScale(.large) // To adjust the size of the icon
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black) // Here you can set the color of the arrow
                }
                .padding()
                Spacer() // Pushes the button to the left
            }
            VStack(alignment: .leading, spacing: 10) {
                // Avatar
                Image(uiImage: UIImage(named: user.avatar_url) ?? UIImage(named: "defaultAvatar")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                // User Details
                HStack {
                    Text("First Name: ").bold()
                    Text(user.firstname)
                }
                
                HStack {
                    Text("Last Name: ").bold()
                    Text(user.lastname)
                }
                
                HStack {
                    Text("Company: ").bold()
                    Text(user.company)
                }
                
                HStack {
                    Text("Job Title: ").bold()
                    Text(user.job_title)
                }
                
                HStack {
                    Text("Email: ").bold()
                    Text(user.email)
                }
                
                // Restaurant Information
                if user.is_enter {
                    HStack {
                        Text("Restaurant: ").bold()
                        Text(user.restaurant_name)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top) .navigationBarBackButtonHidden(true)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User(id: 1, firstname: "John", lastname: "Doe", company: "Acme Inc", job_title: "Developer", email: "johndoe@example.com", restaurant_name: "The Great Eatery", is_enter: true, avatar_url: "defaultAvatar", restaurantId: nil))
    }
}
