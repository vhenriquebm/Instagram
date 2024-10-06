//
//  NotificationService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Firebase

struct NotificationService: NotificationServiceProtocol  {
    
    func uploadNotification(type: NotificationType, post: PostList? = nil, user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid,
              let post = post else { return }
                
        let docReference = COLLECTION_NOTIFICATIONS.document(post.ownerUid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": currentUid,
                                   "type": type.rawValue,
                                   "id": docReference.documentID,
                                   "userProfileImageUrl": user.profileImageUrl,
                                   "userName": user.username ]
        
        
        data["postId"] = post.postId
        data["postImageUrl"] = post.imageUrl
        
        
        print ("DATA - \(data)")
        
        docReference.setData(data)
    }
    
    func getNotifications(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments {snaposhot, _ in
            guard let documents = snaposhot?.documents else { return }
            
            let notifications = documents.map({Notification(dictionary: $0.data())})
            
            print ("Notifications in service \(notifications)")
            
            completion(notifications)
        }
    }
}
