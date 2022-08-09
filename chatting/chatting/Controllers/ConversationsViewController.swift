//
//  ConversationsViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit
import FirebaseAuth

final class ConversationsViewController: UIViewController {
	private let tableView = UITableView()
	
	private let newMessageBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.setImage(UIImage(systemName: "plus"), for: .normal)
		btn.backgroundColor = .systemGray
		btn.tintColor = .white
		btn.imageView?.setSize(height: 24, width: 24)
		btn.addTarget(self, action: #selector(newMessageBtnTapped), for: .touchUpInside)
		return btn
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		configNavBarUI(withTitle: "Message", prefersLargerTitle: true)
		configViewUI()
		configTableView()
		configNewMessageBtn()
		authenticateUser()
    }
	
	func configViewUI() {
		view.backgroundColor = .white
		view.addSubview(tableView)
		
		let image = UIImage(systemName: "person.circle.fill")
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: image,
			style: .plain,
			target: self,
			action: #selector(showProfile)
		)
	}
	
	func configTableView() {
		print(#function)
		tableView.backgroundColor = .white
		tableView.rowHeight = 80
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.conversationCellReuse)
	
		tableView.frame = view.frame
		tableView.tableFooterView = UIView()
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	func configNewMessageBtn() {
		view.addSubview(newMessageBtn)
		newMessageBtn.setAnchorTRBL(
			right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
			paddingRight: 24, paddingBottom: 16, width: 56, height: 56
		)
		newMessageBtn.layer.cornerRadius = 56 / 2
	}
	
	func presentLoginScreen() {
		DispatchQueue.main.async {
			let controller = LoginViewController()
			let nav = UINavigationController(rootViewController: controller)
			nav.modalPresentationStyle = .fullScreen
			self.present(nav, animated: true, completion: nil)
		}
	}
	
	// MARK: Selectors
	@objc func showProfile() {
		// 임시 함수
		logout()
	}
	
	@objc func newMessageBtnTapped() {
		let controller = NewMessageTableViewController()
		let nav = UINavigationController(rootViewController: controller)
		nav.modalPresentationStyle = .fullScreen
		present(nav, animated: true, completion: nil)
	}
	
	// MARK: API
	func authenticateUser() {
		if Auth.auth().currentUser?.uid == nil {
			print("User not Logged In")
			presentLoginScreen()
		} else {
			print("Logged In, \(Auth.auth().currentUser?.uid)")
		}
	}
	
	func logout() {
		do {
			try Auth.auth().signOut()
			presentLoginScreen()
		} catch {
			print(error)
		}
	}
}

extension ConversationsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath.row)
	}
}

extension ConversationsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.conversationCellReuse, for: indexPath)
		cell.textLabel?.text = "?"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
}
