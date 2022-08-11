//
//  Message.swift
//  chatting
//
//  Created by 이승준 on 2022/08/11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Message {
	let text: String
	let toId: String
	let fromId: String
	let isFromCurrentUser: Bool
	var timestamp: Timestamp!
	
	var user: User?
	
	init(dictionary: [String: Any]) {
		self.text = dictionary["text"] as? String ?? ""
		self.toId = dictionary["toId"] as? String ?? ""
		self.fromId = dictionary["fromId"] as? String ?? ""
		self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
		
		self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
	}
}
