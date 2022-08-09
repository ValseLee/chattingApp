//
//  NewMessageTableViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/09.
//

import UIKit

final class NewMessageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		configNavBarUI(withTitle: "Hi", prefersLargerTitle: false)
		configUI()
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
}

extension NewMessageTableViewController {
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.newMessageCellReuse, for: indexPath) as! UserTableViewCell
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
}
