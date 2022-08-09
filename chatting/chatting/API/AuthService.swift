//
//  AuthService.swift
//  chatting
//
//  Created by 이승준 on 2022/08/09.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import UIKit
import Foundation

struct RegistrationCredentials {
	let email: String
	let password: String
	let fullName: String
	let userName: String
	let profileImage: UIImage
}

// Singletone
struct AuthService {
	typealias AuthDataResultCallback = ((AuthDataResult?, Error?) -> Void)
	typealias CreateUserDataCallback = ((Error?) -> Void)
	
	static let shared = AuthService()
	
	func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
		Auth.auth().signIn(withEmail: email, password: password, completion: completion)
	}
	
	func createUser(credentials: RegistrationCredentials, completion: CreateUserDataCallback?) {
		guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.5) else { return }
		let fileName = NSUUID().uuidString
		let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
		
		ref.putData(imageData, metadata: nil) { (meta, error) in
			if let error = error {
				completion!(error)
				return
			}
			
			ref.downloadURL { (url, error) in
				guard let ImageUrl = url?.absoluteString else {
					print("Failed to download Image Url : \(error?.localizedDescription)")
					return
				}
				
				Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
					if let error = error {
						completion!(error)
						return
					}
					
					guard let uid = result?.user.uid else { return }
					
					let data = [
						"email": credentials.email,
						"fullName": credentials.fullName,
						"profileImageUrl": ImageUrl,
						"password": credentials.password,
						"uid": uid,
						"userName": credentials.userName
					] as [String : Any]
					
					Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
				}
			}
		}
	}
}
