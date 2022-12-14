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
	
	func centerY(inView view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
	static let hud = JGProgressHUD(style: .dark)
	
	func configGradientBackground() {
		let gradient = CAGradientLayer()
		gradient.colors = [UIColor.systemGreen.cgColor, UIColor.systemYellow.cgColor]
		gradient.locations = [0.0 , 0.5]
		view.layer.addSublayer(gradient)
		gradient.frame = view.frame
	}
	
	func showLoader(_ show: Bool, withText text: String?) {
		view.endEditing(true)
		UIViewController.hud.textLabel.text = text ?? ""
		
		if show {
			UIViewController.hud.show(in: view)
		} else {
			UIViewController.hud.indicatorView = .none
			UIViewController.hud.dismiss(afterDelay: 2.0, animated: true)
		}
	}
	
	func configNavBarUI(withTitle title: String, prefersLargerTitle: Bool) {		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.backgroundColor = .systemGreen
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		
		navigationController?.navigationBar.prefersLargeTitles = prefersLargerTitle
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.isTranslucent = true
		
		// 시계 색 항상 검은색으로
		navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
		navigationItem.title = title
	}
}

protocol AuthrizationCheck {
	func checkFormStatus()
}

protocol AuthenticationProtocol {
	var formIsValid: Bool { get }
}
