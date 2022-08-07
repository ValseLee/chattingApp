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
	
	private lazy var emailContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "envelope"),
			textField: emailTextField
		)
	}()
	
	private lazy var passwordContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "lock"),
			textField: passwordTextField
		)
	}()
	
	private let emailTextField = CustomTextFields(placeholder: "Email")
	
	private let passwordTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "Password")
		tf.isSecureTextEntry = true
		return tf
	}()
	
	private let loginBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setHeight(height: 50)
		btn.setTitle("Log In", for: .normal)
		btn.setTitleColor(.systemPurple, for: .normal)
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		
		btn.backgroundColor = .clear
		btn.layer.borderWidth = 0.75
		btn.layer.borderColor = UIColor.white.cgColor
		btn.layer.cornerRadius = 20
		return btn
	}()
	
	private let signUpbtn: UIButton = {
		let btn = UIButton(type: .system)
		let attributed = NSMutableAttributedString(
			string: "Don't have an account? ",
			attributes: [
				.font: UIFont.systemFont(ofSize: 16),
				.foregroundColor: UIColor.systemPurple
			]
		)
		
		attributed.append(
			NSAttributedString(
				string: "Sign Up",
				attributes: [
					.font: UIFont.boldSystemFont(ofSize: 16),
					.foregroundColor: UIColor.systemPurple
				]
			)
		)
		
		btn.setAttributedTitle(attributed, for: .normal)
		btn.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
		return btn
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		configNavBarUI()
		configGradientBackground()
		configAutolayout()
		configStackView()
		configSignUpView()
    }
    
	func configNavBarUI() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.barStyle = .black
	}
	
	func configStackView() {
		let stack = UIStackView(
			arrangedSubviews: [
				emailContainerView, passwordContainerView, loginBtn
			]
		)
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
	
	func configSignUpView() {
		view.addSubview(signUpbtn)
		signUpbtn.setAnchorTRBL(
			right: view.safeAreaLayoutGuide.rightAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			left: view.safeAreaLayoutGuide.leftAnchor,
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
	
	// MARK: Selectors
	@objc func showSignUp() {
		let regiVC = RegistrationViewController()
		navigationController?.pushViewController(regiVC, animated: true)
	}
}
