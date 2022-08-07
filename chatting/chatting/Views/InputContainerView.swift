//
//  InputContainerView.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit

// Custom Class: init Utilize
final class InputContainerView: UIView {
	init(image: UIImage?, textField: UITextField) {
		super.init(frame: .zero)
		setHeight(height: 50)
		backgroundColor = .none
		
		let iconView = UIImageView()
		iconView.image = image
		iconView.tintColor = .systemPurple
		
		addSubview(iconView)
		iconView.centerY(inView: self)
		iconView.setAnchorTRBL(
			left: self.leftAnchor,
			paddingLeft: 10
		)
		iconView.setPosition(height: 24, width: 24)
		
		addSubview(textField)
		textField.centerY(inView: self)
		textField.setAnchorTRBL(
			right: self.rightAnchor,
			bottom: self.bottomAnchor,
			left: iconView.rightAnchor,
			paddingRight: 0,
			paddingBottom: 4,
			paddingLeft: 10
		)
		
		let dividerView = UIView()
		dividerView.backgroundColor = .white
		addSubview(dividerView)
		dividerView.setAnchorTRBL(
			right: rightAnchor,
			bottom: bottomAnchor,
			left: leftAnchor,
			paddingRight: 8,
			paddingLeft: 8,
			height: 0.75
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
