//
//  BookMarksController.swift
//  newsapp
//
//  Created by User on 25.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import RealmSwift

class BookMarksController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var bookmarks = UITableView()
    let id = "BookmarkCell"
    let realm = try! Realm()
    var bookmarksData: Results<BookmarksRealm>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarksData = getDataFromDB()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBookmarksTableView(noti:)), name: Notification.Name("reloadBookmarksTableView"), object: nil)
        
        configureView()
        configureBookmarks()
    }
    
    func getDataFromDB() -> Results<BookmarksRealm> {
        let results = realm.objects(BookmarksRealm.self)
        return results
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    func configureBookmarks() {
        bookmarks.register(BookmarksTableCell.self, forCellReuseIdentifier: id)
        self.view.sendSubviewToBack(bookmarks)
        self.bookmarks.delegate = self
        self.bookmarks.dataSource = self
        
        view.addSubview(bookmarks)
        
        addConstraintsOnBookmarks()
    }
    
    func addConstraintsOnBookmarks() {
        bookmarks.translatesAutoresizingMaskIntoConstraints = false
        
        bookmarks.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        bookmarks.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id) as! BookmarksTableCell
        cell.set(bookmarksData: bookmarksData, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsPageController()
        vc.newsData.url = bookmarksData[indexPath.row].url
        present(vc, animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func reloadBookmarksTableView(noti: Notification) {
        bookmarks.reloadData()
    }
}
