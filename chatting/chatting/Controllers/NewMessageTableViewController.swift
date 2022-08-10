//
//  NewMessageTableViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/09.
//

import UIKit

final class NewMessageTableViewController: UITableViewController {
	
	private var users = [User]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configNavBarUI(withTitle: "New Message", prefersLargerTitle: false)
		configUI()
		fetchUsers()
	}
	
	func configUI() {
		view.backgroundColor = .white
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .cancel,
			target: self,
			action: #selector(cancleBtnTapped)
		)
		
		tableView.register(UserTableViewCell.self, forCellReuseIdentifier: Cell.newMessageCellReuse)
		tableView.rowHeight = 80
	}
	
	// MARK: Selectors
	@objc func cancleBtnTapped() {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: API
	func fetchUsers() {
		Service.fetchUsers { users in
			self.users = users
			self.tableView.reloadData()
		}
	}
}

// reloadData() 를 할 때마다 DataSource 프로토콜의 메소드가 실행된다.
extension NewMessageTableViewController {
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.newMessageCellReuse, for: indexPath) as! UserTableViewCell
		cell.user = users[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
}
