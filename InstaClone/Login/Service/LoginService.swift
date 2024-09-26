import Foundation
import Firebase
import FirebaseAuth


typealias loginCompletion = (AuthDataResult?, Error?) -> Void

struct LoginService {
    static func login(with email: String, and password: String, completion: @escaping loginCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Erro ao fazer login: \(error.localizedDescription)")
            }
            completion(authResult, error)
        }
    }
}
