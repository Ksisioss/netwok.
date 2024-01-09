import Foundation

class UserService {
    static let shared = UserService()

    private(set) var user = User(
        id: 1643,
        firstname: "Munch",
        lastname: "Valentin",
        company: "Google",
        job_title: "Developer",
        email: "abcdef@google.inc",
        restaurant_name: "Initial Building",
        is_enter: false,
        avatar_url: "pfp1",
        restaurantId: 2
    )

    private init() {}

    func updateUserProfile(company: String, jobTitle: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        user.company = company
        user.job_title = jobTitle
        user.email = email

        completion(.success(true))
    }
}
