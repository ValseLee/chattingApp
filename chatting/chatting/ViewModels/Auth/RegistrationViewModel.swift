//
//  RegistrationViewModel.swift
//  chatting
//
//  Created by 이승준 on 2022/08/08.
//

import UIKit

struct RegistrationViewModel: AuthenticationProtocol {
	var email: String?
	var fullName: String?
	var userName: String?
	var password: String?
	
	var formIsValid: Bool {
		return email?.isEmpty == false
		&& fullName?.isEmpty == false
		&& userName?.isEmpty == false
		&& password?.isEmpty == false
	}
}
