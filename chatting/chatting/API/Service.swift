//
//  Service.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Service {
	static func fetchUsers(completion: @escaping ([User]) -> Void) {
		var users = [User]()
		Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
			snapshot?.documents.forEach { document in
				let dictionary = document.data()
				let user = User(dictionary: dictionary)
				users.append(user)
				completion(users)
			}
		}
	}
	
	static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
		guard let currentUid = Auth.auth().currentUser?.uid else { return }
		let data = [
			"text": message,
			"fromId": currentUid,
			"toId": user.uid,
			"timestamp": Timestamp(date: Date())
		] as [String: Any]
		
		// 나에게 보내는 메시지도 동일 실행
		COLLECTION_MESSGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
			COLLECTION_MESSGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
		}
		dump(data)
	}
	
	static func fetchMessages(forUser user: User, completion: @escaping ([Message]) -> Void) {
		guard let currentUId = Auth.auth().currentUser?.uid else { return }
		var messages = [Message]()
		let query = COLLECTION_MESSGES.document(currentUId).collection(user.uid).order(by: "timestamp")
		
		query.addSnapshotListener { (snapshot, error) in
			snapshot?.documentChanges.forEach { change in
				switch change.type {
					case .added:
						let dictionary = change.document.data()
						messages.append(Message(dictionary: dictionary))
						completion(messages)
					case .modified:
						print("modified")
					case .removed:
						print("removed")
				}
			}
		}
	}
}
