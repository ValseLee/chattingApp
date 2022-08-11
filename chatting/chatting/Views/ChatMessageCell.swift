//
//  ChatMessageCell.swift
//  chatting
//
//  Created by 이승준 on 2022/08/11.
//

import UIKit

final class ChatMessageCell: UICollectionViewCell {
	
	var message: Message? {
		didSet { configMessageCell() }
	}
	
	var bubbleLeftAnchor: NSLayoutConstraint!
	var bubbleRightAnchor: NSLayoutConstraint!
	
	private let profileImageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.backgroundColor = .systemPurple
		return image
	}()
	
	private let bubbleChatView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemPurple
		return view
	}()
	
	private let chatTextView: UITextView = {
		let chat = UITextView()
		chat.backgroundColor = .clear
		chat.font = .systemFont(ofSize: 16)
		chat.isScrollEnabled = false
		chat.isEditable = false
		chat.textColor = .white
		return chat
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configUI() {
		configProfileImageView()
		configBubbleChatView()
		configChatTextView()
	}
	
	func configProfileImageView() {
		addSubview(profileImageView)
		profileImageView.setAnchorTRBL(bottom: bottomAnchor, left: leftAnchor, paddingBottom: -4, paddingLeft: 8)
		profileImageView.setSize(height: 32, width: 32)
		profileImageView.layer.cornerRadius = 32 / 2
	}
	
	func configBubbleChatView() {
		addSubview(bubbleChatView)
		bubbleChatView.layer.cornerRadius = 12
		bubbleChatView.setAnchorTRBL(top: topAnchor)
		bubbleChatView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
		
		bubbleLeftAnchor = bubbleChatView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
		bubbleRightAnchor = bubbleChatView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
		bubbleLeftAnchor.isActive = false
		bubbleRightAnchor.isActive = false
	}
	
	func configChatTextView() {
		bubbleChatView.addSubview(chatTextView)
		chatTextView.setAnchorTRBL(
			top: bubbleChatView.topAnchor, right: bubbleChatView.rightAnchor, bottom: bubbleChatView.bottomAnchor, left: bubbleChatView.leftAnchor,
			paddingTop: 4, paddingRight: 12, paddingBottom: 4, paddingLeft: 12
		)
	}
	
	func configMessageCell() {
		guard let message = message else { return }
		let viewModel = MessageViewModel(message: message)
		
		bubbleChatView.backgroundColor = viewModel.messageBackgroundColor
		chatTextView.textColor = viewModel.messageTextColor
		chatTextView.text = message.text
		
		bubbleLeftAnchor.isActive = viewModel.isSettedToLeft
		bubbleRightAnchor.isActive = viewModel.isSettedToRight
		profileImageView.isHidden = viewModel.shouldHideProfileImage
	}
}
