//
//  ChatCollectionViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/10.
//

import UIKit

final class ChatCollectionViewController: UICollectionViewController {
	private let user: User
	
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
	
	func configUI() {
		collectionView.backgroundColor = .white
	}

}
