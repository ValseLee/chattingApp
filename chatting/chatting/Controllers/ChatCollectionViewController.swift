//
//  ChatCollectionViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import UIKit

final class ChatCollectionViewController: UICollectionViewController {
	
	private let user: User
	private var messages = [Message]()
	var isCurrentUser = false
	
	private lazy var customInputView: CustomInputAccessoryView = {
		let input = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
		input.delegate = self
		return input
	}()
	
	// MARK: Initializer
	init(user: User) {
		self.user = user
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configUI()
    }
	
	override var inputAccessoryView: UIView? {
		get { return customInputView }
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	func configUI() {
		collectionView.backgroundColor = .white
		configNavBarUI(withTitle: user.userName, prefersLargerTitle: false)
		
		collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: Cell.chatMessageCellReuse)
		collectionView.alwaysBounceVertical = true
	}

}

extension ChatCollectionViewController {
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.chatMessageCellReuse, for: indexPath) as! ChatMessageCell
		cell.message = messages[indexPath.row]
		return cell
	}
}

// Customize Cell Size
extension ChatCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 16, left: 0, bottom: 16, right: 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 50)
	}
}

extension ChatCollectionViewController: CustomInputAccessoryViewDelegate {
	func inputView(_ inputView: CustomInputAccessoryView, wantsToSendMessageWith message: String) {
		Service.uploadMessage(message, to: user) { error in
			if let error = error {
				print("failed to Uplaod message with Error: \(error.localizedDescription)")
				return
			}
			inputView.messageInputTextView.text = nil
		}
	}
}
