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
	
	init(message: Message) {
		self.message = message
	}
}
