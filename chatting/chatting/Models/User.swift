//
//  User.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import Foundation

struct User {
	let uid: String
	let email: String
	let profileImageUrl: String
	let userName: String
	let fullName: String
	
	init(dictionary: [String: Any]) {
		self.uid = dictionary["uid"] as? String ?? ""
		self.email = dictionary["email"] as? String ?? ""
		self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
		self.userName = dictionary["userName"] as? String ?? ""
		self.fullName = dictionary["fullName"] as? String ?? ""
	}
}
