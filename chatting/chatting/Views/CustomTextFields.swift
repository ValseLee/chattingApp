//
//  CustomTextFields.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit

final class CustomTextFields: UITextField {
	init(placeholder: String) {
		super.init(frame: .zero)
		
		borderStyle = .none
		font = UIFont.systemFont(ofSize: 16)
		textColor = .systemGray
		autocorrectionType = .no
		autocapitalizationType = .none
		clearButtonMode = .unlessEditing
		
		attributedPlaceholder = NSAttributedString(
			string: placeholder,
			attributes: [
				.foregroundColor: UIColor.white
			]
		)
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
