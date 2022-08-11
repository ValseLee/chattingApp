//
//  Constanats.swift
//  chatting
//
//  Created by 이승준 on 2022/08/06.
//

import UIKit
import FirebaseFirestore

let COLLECTION_MESSGES = Firestore.firestore().collection("messages")

public struct Cell {
	static let conversationCellReuse = "ConversationCell"
	static let newMessageCellReuse = "MessageCell"
	static let chatCollectionViewCellReuse = "CollectionCell"
	static let chatMessageCellReuse = "ChatMessageCell"
}
