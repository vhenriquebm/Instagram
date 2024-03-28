import Foundation
import Firebase
import FirebaseAuth


typealias loginCompletion = (AuthDataResult?, Error?) -> ()

struct LoginService {
    static func login(with email: String, and password: String, completion: @escaping loginCompletion)  {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
