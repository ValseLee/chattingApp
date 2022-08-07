//
//  RegistrationViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit

final class RegistrationViewController: UIViewController {
	
	private let addProfilePhotoBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
		btn.tintColor = .white
		btn.imageView?.contentMode = .scaleAspectFit
		btn.contentHorizontalAlignment = .fill
		btn.contentVerticalAlignment = .fill
		btn.addTarget(self, action: #selector(addProfilePhoto), for: .touchUpInside)
		return btn
	}()
	
	private lazy var emailContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "envelope"),
			textField: emailTextField
		)
	}()
	
	private lazy var fullNameContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "person"),
			textField: fullNameTextField
		)
	}()
	
	private lazy var userNameContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "person"),
			textField: userNameTextField
		)
	}()
	
	private lazy var passwordContainerView: InputContainerView = {
		return InputContainerView(
			image: UIImage(systemName: "lock"),
			textField: passwordTextField
		)
	}()
	
	private let emailTextField = CustomTextFields(placeholder: "Email")
	
	private let fullNameTextField = CustomTextFields(placeholder: "Full Name")
	
	private let userNameTextField = CustomTextFields(placeholder: "User Name")
	
	private let passwordTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "Password")
		tf.isSecureTextEntry = true
		return tf
	}()
	
	private let signUpBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setHeight(height: 50)
		btn.setTitle("Sign Up", for: .normal)
		btn.setTitleColor(.systemPurple, for: .normal)
		btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		btn.backgroundColor = .clear
		btn.layer.borderWidth = 0.75
		btn.layer.borderColor = UIColor.white.cgColor
		btn.layer.cornerRadius = 20
		return btn
	}()
	
	private let haveAnAccountBtn: UIButton = {
		let btn = UIButton(type: .system)
		let attributed = NSMutableAttributedString(
			string: "You do have an account? ",
			attributes: [
				.font: UIFont.systemFont(ofSize: 16),
				.foregroundColor: UIColor.systemPurple
			]
		)
		
		attributed.append(
			NSAttributedString(
				string: "Log In Here",
				attributes: [
					.font: UIFont.boldSystemFont(ofSize: 16),
					.foregroundColor: UIColor.systemPurple
				]
			)
		)
		
		btn.setAttributedTitle(attributed, for: .normal)
		btn.addTarget(self, action: #selector(toLogInVC), for: .touchUpInside)
		return btn
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemPurple
		configUI()
    }
	
	func configUI() {
		configGradientBackground()
		configAddProfilePhotoBtnView()
		configStackView()
		configHaveAnAccountBtnView()
	}
	
	func configAddProfilePhotoBtnView() {
		view.addSubview(addProfilePhotoBtn)
		addProfilePhotoBtn.translatesAutoresizingMaskIntoConstraints = false
		addProfilePhotoBtn.centerX(inView: view)
		addProfilePhotoBtn.setAnchorTRBL(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
		addProfilePhotoBtn.setSize(height: 150, width: 150)
	}
	
	func configStackView() {
		let stack = UIStackView(
			arrangedSubviews: [
				emailContainerView, fullNameContainerView, userNameContainerView, passwordContainerView, signUpBtn
			]
		)
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 16
		view.addSubview(stack)
		stack.setAnchorTRBL(top: addProfilePhotoBtn.bottomAnchor,
							right: view.rightAnchor,
							left: view.leftAnchor,
							paddingTop: 32,
							paddingRight: 32,
							paddingLeft: 32
		)
	}
	
	func configHaveAnAccountBtnView() {
		view.addSubview(haveAnAccountBtn)
		haveAnAccountBtn.setAnchorTRBL(
			right: view.safeAreaLayoutGuide.rightAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			left: view.safeAreaLayoutGuide.leftAnchor,
			paddingRight: 32,
			paddingLeft: 32
		)
	}
	
	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		 
	}
	
	// MARK: Selectors
	@objc func addProfilePhoto() {
		print("?")
	}
	
	@objc func toLogInVC() {
		navigationController?.popViewController(animated: true)
	}
}
