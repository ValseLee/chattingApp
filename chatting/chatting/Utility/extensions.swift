//
//  extensions.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit
import JGProgressHUD

extension UIView {
	func setAnchorTRBL(top: NSLayoutYAxisAnchor? = nil,
					   right: NSLayoutXAxisAnchor? = nil,
					   bottom: NSLayoutYAxisAnchor? = nil,
					   left: NSLayoutXAxisAnchor? = nil,
					   paddingTop: CGFloat = 0,
					   paddingRight: CGFloat = 0,
					   paddingBottom: CGFloat = 0,
					   paddingLeft: CGFloat = 0,
					   width: CGFloat? = nil,
					   height: CGFloat? = nil) {
		
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}
		
		if let right = right {
			rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
		}
		
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}
		
		if let left = left {
			leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}
		
		if let width = width {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
		if let height = height {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
	
	func centerX(inView view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
	func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
				 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
		
		translatesAutoresizingMaskIntoConstraints = false
		centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
		
		if let left = leftAnchor {
			setAnchorTRBL(left: left, paddingLeft: paddingLeft)
		}
	}
	
	func setSize(height: CGFloat, width: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
		widthAnchor.constraint(equalToConstant: width).isActive = true
	}
	
	func setHeight(height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}
	
	func setWidth(width: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: width).isActive = true
	}
}

extension UIViewController {
	func configGradientBackground() {
		let gradient = CAGradientLayer()
		gradient.colors = [UIColor.systemGreen.cgColor, UIColor.systemYellow.cgColor]
		gradient.locations = [0.0 , 0.5]
		view.layer.addSublayer(gradient)
		gradient.frame = view.frame
	}
	
	func showLoader(_ show: Bool, withText text: String? = "Loading") {
		view.endEditing(true)
		let hud = JGProgressHUD(style: .dark)
		hud.textLabel.text = text
		
		if show {
			hud.show(in: self.view)
		} else {
			hud.dismiss()
		}
	}
}

protocol AuthrizationCheck {
	func checkFormStatus()
}
