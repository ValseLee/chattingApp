//
//  MessgaeViewModel.swift
//  chatting
//
//  Created by 이승준 on 2022/08/11.
//

import Foundation
import UIKit

struct MessageViewModel {
	private let message: Message
	
	var messageBackgroundColor: UIColor {
		return message.isFromCurrentUser
		? .systemGray4
		: .systemPurple
	}
	
	var messageTextColor: UIColor {
		return message.isFromCurrentUser
		? .black
		: .white
	}
	
	var isSettedToRight: Bool {
		return message.isFromCurrentUser
	}
	
	var isSettedToLeft: Bool {
		return !message.isFromCurrentUser
	}
	
	var shouldHideProfileImage: Bool {
		return message.isFromCurrentUser
	}
	
	init(message: Message) {
		self.message = message
	}
}
