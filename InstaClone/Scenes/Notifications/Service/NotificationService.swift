//
//  NotificationService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Firebase

struct NotificationService: NotificationServiceProtocol {

    func uploadNotification(to uid: String, from user: User,
                            type: NotificationType, post: PostList? = nil) {

        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        guard uid != currentUid else { return }

        let docReference = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()

        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": user.uid,
                                   "type": type.rawValue,
                                   "id": docReference.documentID,
                                   "userProfileImageUrl": user.profileImageUrl,
                                   "userName": user.username ]

        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }

        docReference.setData(data)
    }

    func getNotifications(completion: @escaping ([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments {snaposhot, _ in
            guard let documents = snaposhot?.documents else { return }

            let notifications = documents.map({Notification(dictionary: $0.data())})

            print("Notifications in service \(notifications)")

            completion(notifications)
        }
    }
}
