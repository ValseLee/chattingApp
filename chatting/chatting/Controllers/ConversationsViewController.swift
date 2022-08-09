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

    override func viewDidLoad() {
        super.viewDidLoad()
		configViewUI()
		configNavBarUI()
		configTableView()
		authenticateUser()
    }
	
	func configViewUI() {
		view.backgroundColor = .white
		view.addSubview(tableView)
	}
	
	func configNavBarUI() {
		let image = UIImage(systemName: "person.circle.fill")
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: image,
			style: .plain,
			target: self,
			action: #selector(showProfile)
		)
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.backgroundColor = .systemGray
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.isTranslucent = true
		
		// 시계 색 항상 검은색으로
		navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
		navigationItem.title = "Messages"
	}
	
	func configTableView() {
		print(#function)
		tableView.backgroundColor = .white
		tableView.rowHeight = 80
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.cellReuse)
	
		tableView.frame = view.frame
		tableView.tableFooterView = UIView()
		
		tableView.delegate = self
		tableView.dataSource = self
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
		print("?")
		logout()
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
			print("logout succeed")
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
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.cellReuse, for: indexPath)
		cell.textLabel?.text = "?"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
}
