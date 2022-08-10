//
//  ChatCollectionViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import UIKit

final class ChatCollectionViewController: UICollectionViewController {
	
	private let user: User
	
	private lazy var customInputView: CustomInputAccessoryView = {
		let input = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
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
	}

}
