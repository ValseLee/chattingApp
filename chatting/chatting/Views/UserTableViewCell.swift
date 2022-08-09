//
//  UserTableViewCell.swift
//  chatting
//
//  Created by 이승준 on 2022/08/09.
//

import UIKit

class UserTableViewCell: UITableViewCell {
	private let profileImageView: UIImageView = {
		let image = UIImageView()
		image.backgroundColor = .purple
		image.contentMode = .scaleToFill
		image.clipsToBounds = true
		image.setSize(height: 56, width: 56)
		image.layer.cornerRadius = 56 / 2
		return image
	}()
	
	private let userNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.text = "Water?"
		return label
	}()
		
	private let fullNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .lightGray
		label.text = "Name?"
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configUI() {
		configImageView()
		configStackView()
	}
	
	func configImageView() {
		addSubview(profileImageView)
		profileImageView.centerY(inView: self)
		profileImageView.setAnchorTRBL(left: leftAnchor, paddingLeft: 12)
	}
	
	func configStackView() {
		let stack = UIStackView(arrangedSubviews: [
			userNameLabel, fullNameLabel
		])
		stack.axis = .vertical
		stack.spacing = 2.0
		addSubview(stack)
		
		stack.centerY(inView: profileImageView)
		stack.setAnchorTRBL(
			left: profileImageView.rightAnchor,
			paddingLeft: 12
		)
		
	}
}
