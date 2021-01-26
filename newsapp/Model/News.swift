//
//  News.swift
//  newsapp
//
//  Created by User on 8.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

struct News: Codable {
    var status: String
    var code: String?
    var message: String?
    var totalResults: Int?
    var articles: [ApiNews]?
}

struct ApiNews: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct Bookmarks: Codable {
    var description: String
    var note: String
    var title: String
    var url: String
}
