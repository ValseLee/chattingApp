//
//  LoginViewModel.swift
//  chatting
//
//  Created by 이승준 on 2022/08/08.
//

import UIKit

struct LoginViewModel {
	var email: String?
	var password: String?
	
	var formIsValid: Bool {
		return email?.isEmpty == false
		&& password?.isEmpty == false
	}
}
