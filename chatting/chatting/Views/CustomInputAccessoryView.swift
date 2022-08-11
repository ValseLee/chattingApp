//
//  CustomInputView.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import UIKit

// MARK: Custom Delegate
protocol CustomInputAccessoryViewDelegate: AnyObject {
	func inputView(_ inputView: CustomInputAccessoryView, wantsToSendMessageWith message: String)
}

final class CustomInputAccessoryView: UIView {
	
	weak var delegate: CustomInputAccessoryViewDelegate?
	
	private lazy var messageInputTextView: UITextView = {
		let input = UITextView()
		input.font = .systemFont(ofSize: 16)
		input.isScrollEnabled = false
		input.autocorrectionType = .no
		return input
	}()
	
	private let placeholderLabel: UILabel = {
		let label = UILabel()
		label.text = "Enter Message"
		label.font = .systemFont(ofSize: 16)
		label.textColor = .systemGray
		return label
	}()
	
	private lazy var sendBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setTitle("Send", for: .normal)
		btn.setTitleColor(.systemGreen, for: .normal)
		btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
		btn.addTarget(self, action: #selector(sendBtnTapped), for: .touchUpInside)
		return btn
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configUI()
		setNotification()
		autoresizingMask = .flexibleHeight
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		return .zero
	}
	
	func configUI() {
		configViewShadow()
		configSendBtn()
		configInputTextView()
		configPlaceholderLabel()
	}
	
	func configViewShadow() {
		backgroundColor = .white
		layer.shadowOpacity = 0.15
		layer.shadowRadius = 7
		layer.shadowOffset = .init(width: 0, height: -3)
		layer.shadowColor = UIColor.lightGray.cgColor
	}
	
	func configSendBtn() {
		addSubview(sendBtn)
		sendBtn.setAnchorTRBL(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
		sendBtn.setSize(height: 50, width: 50)
	}
	
	func configInputTextView() {
		addSubview(messageInputTextView)
		messageInputTextView.setAnchorTRBL(
			top: topAnchor, right: sendBtn.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, left: leftAnchor,
			paddingTop: 12, paddingRight: 8, paddingBottom: 8, paddingLeft: 8
		)
	}
	
	func configPlaceholderLabel() {
		addSubview(placeholderLabel)
		placeholderLabel.setAnchorTRBL(left: messageInputTextView.leftAnchor,paddingLeft: 4)
		placeholderLabel.centerY(inView: messageInputTextView)
	}
	
	func setNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(textInputDidChange), name: UITextView.textDidChangeNotification, object: nil)
	}
	
	func clearMessageText() {
		messageInputTextView.text = nil
		placeholderLabel.isHidden = false
	}
	
	// MARK: Selectors
	@objc func sendBtnTapped() {
		guard let message = messageInputTextView.text else { return }
		delegate?.inputView(self, wantsToSendMessageWith: message)
	}
	
	@objc func textInputDidChange() {
		placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
	}
	
}
