//
//  UserService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Firebase

typealias profileCompletion = (User) -> ()
typealias usersCompletion = (([User]) -> ())
typealias FirestoreCompletion = (Error?) -> Void
typealias UserStatsCompletion = (UserStats) -> ()

struct ProfileService {
    static func getUser(completion: @escaping profileCompletion) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}

extension ProfileService {
    
    static func getUsers(completion: @escaping usersCompletion) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map {User(dictionary: $0.data())}
            completion(users)
        }
    }
}

extension ProfileService {
    func follow(uid: String, completion: @escaping FirestoreCompletion) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following")
            .document(uid).setData([:]) { error in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUid)
                    .setData([:], completion: completion)
            }
    }
    
    func unfollow(uid: String, completion: @escaping FirestoreCompletion) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following")
            .document(uid).delete { error in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers").document(currentUid)
                    .delete(completion: completion)
            }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).getDocument { snapshot, error in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
}


//MARK: - User Stats

extension ProfileService {
    func getUserStats(uid: String, completion: @escaping UserStatsCompletion) {
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
            .getDocuments { snapshot, _ in
                
                let followers = snapshot?.documents.count ?? 0
                
                COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                    let following = snapshot?.documents.count ?? 0
                    
                    completion(UserStats(followers: followers, following: following))
                    
                }
            }
    }
}

extension ProfileService {
    
    func getPosts(with uuid: String, completion: @escaping ([PostList]) -> ()) {
        let query = COLLECTION_POSTS
            .whereField("ownerUid", isEqualTo: uuid)

        query.getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map { PostList(postId: $0.documentID, dictionary: $0.data())}
            
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)
        }
    }
}
