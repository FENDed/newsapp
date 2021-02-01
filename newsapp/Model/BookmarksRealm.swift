//
//  DBClass.swift
//  newsapp
//
//  Created by User on 27.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import Foundation
import RealmSwift

class BookmarksRealm: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var url: String?
    @objc dynamic var urlToImage: String?
    @objc dynamic var note: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
