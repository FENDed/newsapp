//
//  NewsPageController.swift
//  newsapp
//
//  Created by User on 18.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import WebKit
import FirebaseDatabase

class NewsPageController: UIViewController {
    
    var newsPageView = UIView()
    var newsNavigationController = UINavigationController()
    var newsPageWebView = WKWebView()
    let addToBookmarksButton = UIButton()
    
    var newsData = ApiNews(author: nil, title: nil, description: nil, url: "", urlToImage: nil, publishedAt: "", content: nil)
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNewsPageView()
        configureAddToBookmarksButton()
        configureNewsPageWebView()
        loadNewsPage()
    }
    
    func configureNewsPageView() {
        addToBookmarksButton.setTitle("Add to bookmarks", for: .normal)
        addToBookmarksButton.addTarget(self, action: #selector(addToBookmarks), for: .touchUpInside)
        view.backgroundColor = .black

        view.addSubview(newsPageView)
        
        configureAddToBookmarksButton()
        addConstraintsToBookMarksButton()
    }
    
    func addConstraintsToBookMarksButton() {
        addToBookmarksButton.translatesAutoresizingMaskIntoConstraints = false
        addToBookmarksButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true
        addToBookmarksButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func configureAddToBookmarksButton() {
        addToBookmarksButton.tintColor = .blue
        view.addSubview(addToBookmarksButton)
    }
    
    func configureNewsPageWebView() {
        view.addSubview(newsPageWebView)
    
        addConstraintsToNewsPageWebView()
    }
    
    func addConstraintsToNewsPageWebView() {
        newsPageWebView.translatesAutoresizingMaskIntoConstraints = false
        newsPageWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        newsPageWebView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        newsPageWebView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        newsPageWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    func loadNewsPage() {
        let url = URL(string: newsData.url)
        let urlRequest = URLRequest(url: url!)
    
        newsPageWebView.load(urlRequest)
    }
    
    
    @objc func addToBookmarks(sender: UIButton!) {
        ref.child("BookMarks").setValue([[
            "title": newsData.title,
            "description": newsData.description,
            "url": newsData.url,
            "note": "No note"
        ]])
    }
}

