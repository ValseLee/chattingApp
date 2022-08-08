//
//  LoginViewModel.swift
//  chatting
//
//  Created by 이승준 on 2022/08/08.
//

import UIKit

protocol AuthenticationProtocol {
	var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
	var email: String?
	var password: String?
	
	var formIsValid: Bool {
		return email?.isEmpty == false
		&& password?.isEmpty == false
	}
}
