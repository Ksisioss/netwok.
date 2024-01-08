import Foundation

class UserService {
    static let shared = UserService()

    private(set) var user = User(
        lastame: "Munch",
        firstname: "Valentin",
        company: "Google",
        job_title: "Developer",
        email: "abcdef@google.inc",
        building: "Initial Building",
        inside: false,
        avatar: nil
    )

    private init() {}

    func updateUserProfile(company: String, jobTitle: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        user.company = company
        user.job_title = jobTitle
        user.email = email

        completion(.success(true))
    }
}
