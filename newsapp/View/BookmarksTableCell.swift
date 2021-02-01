//
//  BookmarksTableCell.swift
//  newsapp
//
//  Created by User on 25.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarksTableCell: UITableViewCell {

    var newsImage = CustomImageView()
    var newsTitle = UILabel()
    var newsDescription = UILabel()
    var showNoteButton = UIButton()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(newsImage)
        addSubview(newsTitle)
        addSubview(newsDescription)
        addSubview(showNoteButton)

        configureNewsImage()
        configureNewsTitle()
        configureNewsDescription()
        
        setNewsImageConstraints()
        setNewsTitleConstraints()
        setNewsDescriptionConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(bookmarksData: Results<BookmarksRealm>, row: Int) {
        newsImage.image = UIImage(named: "no-image")
        
        if let urlString = bookmarksData[row].urlToImage, let url = URL(string: urlString) {
            newsImage.loadImage(from: url)
        }
        
        newsTitle.text = bookmarksData[row].title
        newsDescription.text = bookmarksData[row].desc
    }
    
    func configureNewsImage() {
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
    }
    
    func configureNewsTitle() {
        newsTitle.numberOfLines = 0
        newsTitle.adjustsFontSizeToFitWidth = true
        newsTitle.textAlignment = .center
    }
    
    func configureNewsDescription() {
        newsDescription.numberOfLines = 2
        newsDescription.adjustsFontForContentSizeCategory = false
        newsDescription.font = UIFont.systemFont(ofSize: 16)
        newsDescription.textAlignment = .justified
    }
    
    func setNewsImageConstraints() {
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setNewsTitleConstraints() {
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        newsTitle.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 20).isActive = true
        newsTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    func setNewsDescriptionConstraints() {
        newsDescription.translatesAutoresizingMaskIntoConstraints = false
        newsDescription.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10).isActive = true
        newsDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        newsDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
