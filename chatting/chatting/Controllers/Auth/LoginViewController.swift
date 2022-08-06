//
//  LoginViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit

final class LoginViewController: UIViewController {
	
	private let iconImage: UIImageView = {
		let mainImage = UIImageView()
		mainImage.image = UIImage(systemName: "bubble.right")
		mainImage.translatesAutoresizingMaskIntoConstraints = false
		mainImage.clipsToBounds = true
		mainImage.tintColor = .white
		return mainImage
	}()
	
	private lazy var emailContainerView: UIView = {
		let container = UIView()
		container.backgroundColor = .none
		container.setHeight(height: 50)
		
		let iconView = UIImageView()
		iconView.image = UIImage(systemName: "envelope")
		iconView.tintColor = .black
		
		container.addSubview(iconView)
		iconView.centerY(inView: container)
		iconView.setAnchorTRBL(left: container.leftAnchor, paddingLeft: 10)
		iconView.setPosition(height: 24, width: 24)
		
		container.addSubview(emailTextField)
		emailTextField.centerY(inView: container)
		emailTextField.setAnchorTRBL(right: container.rightAnchor,
									 bottom: container.bottomAnchor,
									 left: iconView.rightAnchor,
									 paddingRight: 0,
									 paddingBottom: 4,
									 paddingLeft: 10
		)
		
		return container
	}()
	
	private let emailTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Email"
		tf.autocorrectionType = .no
		tf.autocapitalizationType = .none
		return tf
	}()
	
	private lazy var passwordContainerView: UIView = {
		let container = UIView()
		container.backgroundColor = .none
		container.setHeight(height: 50)
		
		let iconView = UIImageView()
		iconView.image = UIImage(systemName: "lock")
		iconView.tintColor = .black
		
		container.addSubview(iconView)
		iconView.centerY(inView: container)
		iconView.setAnchorTRBL(left: container.leftAnchor, paddingLeft: 10)
		iconView.setPosition(height: 24, width: 24)
		
		container.addSubview(passwordTextField)
		passwordTextField.centerY(inView: container)
		passwordTextField.setAnchorTRBL(right: container.rightAnchor,
									 bottom: container.bottomAnchor,
									 left: iconView.rightAnchor,
									 paddingRight: 0,
									 paddingBottom: 0,
									 paddingLeft: 10
		)
		return container
	}()
	
	private let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Password"
		tf.isSecureTextEntry = true
		return tf
	}()
	
	private let loginBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setTitle("Log In", for: .normal)
		btn.layer.cornerRadius = 5.0
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		btn.backgroundColor = .systemGreen
		btn.setHeight(height: 50)
		return btn
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		configNavBarUI()
		configGradientBackground()
		configAutolayout()
		configStackView()
    }
    
	func configNavBarUI() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.barStyle = .black
	}
	
	func configStackView() {
		let stack = UIStackView(arrangedSubviews: [
			emailContainerView, passwordContainerView, loginBtn
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 16
		view.addSubview(stack)
		stack.setAnchorTRBL(top: iconImage.bottomAnchor,
							right: view.rightAnchor,
							left: view.leftAnchor,
							paddingTop: 32,
							paddingRight: 32,
							paddingLeft: 32
		)
	}
	
	func configAutolayout() {
		view.addSubview(iconImage)
		iconImage.centerX(inView: view)
		iconImage.setAnchorTRBL(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
		iconImage.setPosition(height: 120, width: 120)

//		NSLayoutConstraint.activate([
//			iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//			iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//			iconImage.heightAnchor.constraint(equalToConstant: 120),
//			iconImage.widthAnchor.constraint(equalToConstant: 120),
//		])
	}
	
	func configGradientBackground() {
		let gradient = CAGradientLayer()
		gradient.colors = [UIColor.systemGreen.cgColor, UIColor.systemYellow.cgColor]
		gradient.locations = [0.0 , 0.5]
		view.layer.addSublayer(gradient)
		gradient.frame = view.frame
	}
}
