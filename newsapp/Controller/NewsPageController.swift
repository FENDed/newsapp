//
//  NewsPageController.swift
//  newsapp
//
//  Created by User on 18.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift


class NewsPageController: UIViewController {
    
    var newsPageView = UIView()
    var newsNavigationController = UINavigationController()
    var newsPageWebView = WKWebView()
    var editNote = UIButton()
    var addImage = UIImage(named: "add")
    var removeImage = UIImage(named: "remove")
    var shareImage = UIImage(named: "share")
    var bookmarksActionButton = UIButton()
    var closeNoteButton = UIButton()
    var shareButton = UIButton()
    var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    var backgroundView = UIVisualEffectView()
    var bookmarkTextView = UITextView()
    
    let realm = try! Realm()
    
    
    
    var newsData = ApiNews(author: nil, title: nil, description: nil, url: "", urlToImage: nil, publishedAt: "", content: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNewsPageView()
        configurebookmarksActionButton()
        configureNewsPageWebView()
        loadNewsPage()
        addEditNote()
        configureBackgroundView()
        configureBookmarkTextView()
        configureCloseNoteButton()
        configureShareButton()
    }
    
    func configureNewsPageView() {
        view.backgroundColor = .black
        view.addSubview(newsPageView)
    }
    
    func configurebookmarksActionButton() {
        if isAddedInBookmarks() {
            bookmarksActionButton.setImage(removeImage, for: .normal)
        }else {
            bookmarksActionButton.setImage(addImage, for: .normal)
        }
        
        bookmarksActionButton.addTarget(self, action: #selector(bookmarksAction), for: .touchUpInside)
        view.addSubview(bookmarksActionButton)
        
        addConstraintsTobookmarksActionButton()
    }
    
    func addConstraintsTobookmarksActionButton() {
        bookmarksActionButton.translatesAutoresizingMaskIntoConstraints = false
        
        bookmarksActionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        bookmarksActionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
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
    
    func addEditNote() {
        if isAddedInBookmarks() && (UserDefaults.standard.bool(forKey: "isAuth") || (UserDefaults.standard.string(forKey: "bookmarksPassword")?.count ?? 0 == 0)) {
            editNote.alpha = 1
        } else {
            editNote.alpha = 0
        }
        
        editNote.setImage(UIImage(named: "edit"), for: .normal)
        editNote.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        view.addSubview(editNote)
        
        addConstraintsOnEditNote()
    }
    
    func addConstraintsOnEditNote() {
        editNote.translatesAutoresizingMaskIntoConstraints = false
        
        editNote.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        editNote.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        editNote.heightAnchor.constraint(equalToConstant: 28).isActive = true
        editNote.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func configureBookmarkTextView() {
        bookmarkTextView.alpha = 0
        bookmarkTextView.textContainerInset = UIEdgeInsets(top: 30, left: 5, bottom: 5, right: 5)
        view.bringSubviewToFront(bookmarkTextView)
        view.addSubview(bookmarkTextView)
        
        addConstraintsOnBookmarkTextView()
    }
    
    func addConstraintsOnBookmarkTextView() {
        bookmarkTextView.translatesAutoresizingMaskIntoConstraints = false
        
        bookmarkTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookmarkTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bookmarkTextView.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        bookmarkTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configureCloseNoteButton() {
        closeNoteButton.alpha = 0
        closeNoteButton.setImage(UIImage(named: "close"), for: .normal)
        closeNoteButton.addTarget(self, action: #selector(closeNote), for: .touchUpInside)
        view.bringSubviewToFront(closeNoteButton)
        view.addSubview(closeNoteButton)
        
        addConstraintsOnCloseNoteButton()
    }
    
    func addConstraintsOnCloseNoteButton() {
        closeNoteButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeNoteButton.rightAnchor.constraint(equalTo: bookmarkTextView.rightAnchor, constant: 0).isActive = true
        closeNoteButton.topAnchor.constraint(equalTo: bookmarkTextView.topAnchor, constant: 0).isActive = true
    }
    
    func configureShareButton() {
        shareButton.setImage(shareImage, for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        view.addSubview(shareButton)
        
        addConstraintsOnShareButton()
    }
    
    func addConstraintsOnShareButton() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.leftAnchor.constraint(equalTo: editNote.rightAnchor, constant: 10).isActive = true
        shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    }
        
    func configureBackgroundView() {
        backgroundView.alpha = 0
        backgroundView.effect = blurEffect
        view.addSubview(backgroundView)
        view.bringSubviewToFront(backgroundView)
        
        addConstraintsOnBackgroundView()
    }

    func addConstraintsOnBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func loadNewsPage() {
        guard let urlString = newsData.url,
              let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            return
        }
        let urlRequest = URLRequest(url: url)

        newsPageWebView.load(urlRequest)
    }
    
    func isAddedInBookmarks() -> Bool {
        let data = realm.objects(BookmarksRealm.self)
        
        if data.count >= 1 {
            for i in 0...(data.count - 1) {
                if newsData.url == data[i].url {
                    return true
                }
            }
        }
        
        return false
    }
    
    @objc func addNote(sender: UIButton!) {
        if let obj = realm.objects(BookmarksRealm.self).filter("url = %@", newsData.url!).first {
            bookmarkTextView.text = obj.note
        }
        
        backgroundView.alpha = 1
        closeNoteButton.alpha = 1
        bookmarkTextView.alpha = 1
        
    }
    
    @objc func closeNote(sender: UIButton!) {
        backgroundView.alpha = 0
        closeNoteButton.alpha = 0
        bookmarkTextView.alpha = 0
        
        if let obj = realm.objects(BookmarksRealm.self).filter("url = %@", newsData.url!).first {
            try! realm.write {
                obj.note = bookmarkTextView.text
            }
        }
    }
    
    @objc func share(sender: UIButton!) {
        let shareViewController = UIActivityViewController(activityItems: [newsData.url!], applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    @objc func bookmarksAction(sender: UIButton!) {
        if isAddedInBookmarks() {
            if let obj = realm.objects(BookmarksRealm.self).filter("url = %@", newsData.url!).first {
                newsData.description = obj.desc
                newsData.urlToImage = obj.urlToImage
                newsData.title = obj.title
                
                try! realm.write {
                    realm.delete(obj)
                }
            }
            sender.setImage(addImage, for: .normal)
            editNote.alpha = 0
            NotificationCenter.default.post(name: Notification.Name("reloadBookmarksTableView"), object: nil)
        }else {
            let bookmarksRealm = BookmarksRealm()
            
            bookmarksRealm.title = newsData.title
            bookmarksRealm.desc = newsData.description
            bookmarksRealm.url = newsData.url
            bookmarksRealm.urlToImage = newsData.urlToImage
            
            try! realm.write {
                realm.add(bookmarksRealm)
            }
            
            sender.setImage(removeImage, for: .normal)
            editNote.alpha = 1
            NotificationCenter.default.post(name: Notification.Name("reloadBookmarksTableView"), object: nil)
        }
    }
}
