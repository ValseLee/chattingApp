//
//  ConversationsViewController.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		configViewUI()
		configNavUI()
    }
	
	func configViewUI() {
		view.backgroundColor = .white
	}
	
	func configNavUI() {
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
	
	@objc func showProfile() {
		print("?/")
	}
}
