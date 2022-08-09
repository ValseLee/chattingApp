//
//  RegistrationViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

final class RegistrationViewController: UIViewController, UINavigationControllerDelegate {
	
	private var viewModel = RegistrationViewModel()
	private var profileImage: UIImage?
	
	private let addProfilePhotoBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
		btn.tintColor = .white
		btn.imageView?.contentMode = .scaleAspectFit
		btn.clipsToBounds = true
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
	
	private let emailTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "Email")
		tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
		return tf
	}()
	
	private let fullNameTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "Full Name")
		tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
		return tf
	}()
	
	private let userNameTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "User Name")
		tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
		return tf
	}()
	
	private let passwordTextField: CustomTextFields = {
		let tf = CustomTextFields(placeholder: "Password")
		tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
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
		btn.addTarget(self, action: #selector(handleSignUpBtn), for: .touchUpInside)
		btn.isEnabled = false
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
	
	// MARK: Selectors
	@objc func addProfilePhoto() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
	}
	
	@objc func toLogInVC() {
		navigationController?.popViewController(animated: true)
	}
	
	// 회원가입 로직, 리팩토링 무조건
	@objc func handleSignUpBtn() {
		guard let email = emailTextField.text else { return }
		guard let fullName = fullNameTextField.text else { return }
		guard let userName = userNameTextField.text?.lowercased() else { return }
		guard let password = passwordTextField.text else { return }
		guard let profileImage = profileImage else { return }
		
		guard let imageData = profileImage.jpegData(compressionQuality: 0.5) else { return }
		let fileName = NSUUID().uuidString
		let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
		ref.putData(imageData, metadata: nil) { (meta, error) in
			if let error = error {
				print("Failed to upload image : \(error.localizedDescription)")
				return
			}
			
			ref.downloadURL { (url, error) in
				guard let ImageUrl = url?.absoluteString else {
					print("Failed to upload image : \(error?.localizedDescription)")
					return
				}
				
				Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
					if let error = error {
						print("Failed to create User : \(error.localizedDescription)")
						return
					}
					
					guard let uid = result?.user.uid else { return }
					
					let data = [
						"email": email,
						"fullName": fullName,
						"profileImageUrl": ImageUrl,
						"password": password,
						"uid": uid,
						"userName": userName
					] as [String : Any]
					
					Firestore.firestore().collection("users").document(uid).setData(data) { error in
						if let error = error {
							print("Failed to upload user Data : \(error.localizedDescription)")
							return
						}
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
		}
	}
	
	@objc func textDidChange(sender: UITextField) {
		if sender == emailTextField {
			viewModel.email = sender.text
		} else if sender == fullNameTextField {
			viewModel.fullName = sender.text
		} else if sender == userNameTextField {
			viewModel.userName = sender.text
		} else {
			viewModel.password = sender.text
		}
		checkFormStatus()
	}
}

extension RegistrationViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[.originalImage] as? UIImage
		profileImage = image
		addProfilePhotoBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
		addProfilePhotoBtn.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
		addProfilePhotoBtn.imageView?.contentMode = .scaleAspectFill
		addProfilePhotoBtn.layer.borderWidth = 1.5
		addProfilePhotoBtn.layer.cornerRadius = 150 / 2
		dismiss(animated: true, completion: nil)
	}
}

extension RegistrationViewController: AuthrizationCheck {
	
	func checkFormStatus() {
		if viewModel.formIsValid {
			signUpBtn.isEnabled = true
			signUpBtn.layer.borderWidth = 0.0
			signUpBtn.backgroundColor = .systemGreen
			signUpBtn.setTitleColor(.white, for: .normal)
		} else {
			signUpBtn.backgroundColor = .clear
		}
	}
}
