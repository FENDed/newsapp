//
//  BookMarksController.swift
//  newsapp
//
//  Created by User on 25.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookMarksController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let ref = Database.database().reference()
    var bookmarks = UITableView()
    var newsData: [[String: Any]] = [[:]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromDB()
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    func configureBookmarks() {
        bookmarks.register(NewsTableCell.self, forCellReuseIdentifier: "BookmarkCell")
        self.bookmarks.delegate = self
        self.bookmarks.dataSource = self
        
        view.addSubview(bookmarks)
        addConstraintsOnBookmarks()
    }
    
    func addConstraintsOnBookmarks() {
        bookmarks.translatesAutoresizingMaskIntoConstraints = false
        bookmarks.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bookmarks.leadingAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
//    DataBase functions
    
    func getDataFromDB() {
        ref.child("BookMarks").observeSingleEvent(of: .value) { (snapshot) in
            let postDict = snapshot.value as? [[String: Any]]
//            for aValue in postDict {
//                let title = aValue["title"] as? String
//
//            }
            //newsData = postDict
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: id) as! NewsTableCell
//        let someNews = newsData[indexPath.row]
//        cell.set(news: someNews)
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = NewsPageController()
//        vc.newsData = newsData[indexPath.row]
//        present(vc, animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
