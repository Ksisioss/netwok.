import SwiftUI

struct SearchUserView: View {
    @ObservedObject var viewModel = UserViewModel()

    var filteredUsers: [User] {
        viewModel.users.filter { user in
            (viewModel.searchText.isEmpty || user.firstname.localizedCaseInsensitiveContains(viewModel.searchText) || user.lastname.localizedCaseInsensitiveContains(viewModel.searchText))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by name...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(filteredUsers, id: \.id) { user in
                    NavigationLink(destination: UserDetailsView(user: user)) {
                        VStack(alignment: .leading) {
                            Text("\(user.firstname) \(user.lastname)")
                            Text("Company: \(user.company)")
                            Text("Position: \(user.job_title)")
                        }
                    }
                }
            }
        }
    }
}

struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()
    }
}
