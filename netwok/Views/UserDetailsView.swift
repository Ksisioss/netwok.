import SwiftUI


class UserDetailsViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false

    func loadUserData(userId: Int) {
        isLoading = true
    
        DispatchQueue.global(qos: .userInitiated).async {
            //let fetchedUser =
            DispatchQueue.main.async {
                //self.user = fetchedUser
                self.isLoading = false
            }
        }
    }
}

struct ParentView: View {
    @StateObject var viewModel = UserDetailsViewModel()
    @State private var showUserDetails = false

    var body: some View {
        VStack {
            // Your content
        }
        .onAppear {
            viewModel.loadUserData(userId: 123) // Start loading the user data
        }
        .sheet(isPresented: $showUserDetails) {
            if let user = viewModel.user {
                UserDetailsView(user: user)
            }
        }
        .onChange(of: viewModel.isLoading) { isLoading in
            if !isLoading {
                // Once the data is loaded, present the sheet
                showUserDetails = true
            }
        }
    }
}

struct UserDetailsView: View {
    var user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    backButton
                    avatar
                    restaurantPinIndicator()
                        .offset(x: 105, y: -130)
                    greeting
                    VStack(alignment: .center) {
                        informationGrid
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
                    Text("First Name: ").font(Font.custom("Manrope-Bold", size: 18))
                    Text(user.firstname)
                        .font(Font.custom("Manrope-Regular", size: 18))
                }
                
                HStack {
                    Text("Last Name: ").font(Font.custom("Manrope-Bold", size: 18))
                    Text(user.lastname)
                        .font(Font.custom("Manrope-Regular", size: 18))
                }
                
                HStack {
                    Text("Company: ").font(Font.custom("Manrope-Bold", size: 18))
                    Text(user.company)
                        .font(Font.custom("Manrope-Regular", size: 18))
                }
                
                HStack {
                    Text("Job Title: ").font(Font.custom("Manrope-Bold", size: 18))
                    Text(user.job_title)
                        .font(Font.custom("Manrope-Regular", size: 18))
                }
                
                HStack {
                    Text("Email: ").font(Font.custom("Manrope-Bold", size: 18))
                    Text(user.email)
                        .font(Font.custom("Manrope-Regular", size: 18))
                }
                
                // Restaurant Information
                if user.is_enter {
                    HStack {
                        Text("Restaurant: ").font(Font.custom("Manrope-Bold", size: 18))
                        Text(user.restaurant_name)
                            .font(Font.custom("Manrope-Regular", size: 18))
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
    public func restaurantPinIndicator() -> some View {
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
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    detailItem(title: "Company", value: user.company)
                    detailItem(title: "Email", value: user.email, isEmail: true)
                }
                Spacer()
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    detailItem(title: "Job Title", value: user.job_title)
                    if user.is_enter {
                        detailItem(title: "Restaurant", value: user.restaurant_name)
                    }
                }
                Spacer()
            }
            Spacer()
        }.padding(.horizontal)
            .padding(.top, -40)
    }
    
    func detailItem(title: String, value: String, isEmail: Bool = false) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Manrope-Bold", size: 18))
                .fontWeight(.bold)
            
            if isEmail {
                Button(action: {
                    // Your action to open the mail application
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
    
    public func openMail(email: String) {
        if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    var imagesGrid: some View {
        let imageNames = [
            "pic_1", "pic_2", "pic_3", "pic_4", "pic_5",
            "pic_6", "pic_7", "pic_8", "pic_9", "pic_10",
            "pic_11", "pic_12", "pic_13", "pic_14", "pic_15",
            "pic_16", "pic_17", "pic_18", "pic_19"
        ]
        let randomImages = imageNames.shuffled().prefix(4)
        
        return LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.fixed(150))], spacing: 20) {
            ForEach(Array(randomImages), id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(22)
                    .shadow(radius: 20)
            }
        }
    }

    
    struct UserDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            UserDetailsView(user: User(id: 1, firstname: "First", lastname: "Last", company: "Acme Inc", job_title: "Developer", email: "johndoe@example.com", restaurant_name: "The Great Eatery", is_enter: true, avatar_url: "defaultAvatar", restaurantId: nil))
        }
    }
}
