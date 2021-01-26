//
//  NewsTableCell.swift
//  newsapp
//
//  Created by User on 8.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableCell: UITableViewCell {
    
    var newsImage = UIImageView()
    var newsTitle = UILabel()
    var newsDescription = UILabel()
    var newsPublishDate = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(newsImage)
        addSubview(newsTitle)
        addSubview(newsDescription)
        addSubview(newsPublishDate)
        
        configureNewsImage()
        configureNewsTitle()
        configureNewsDescription()
        configureNewsPublishDate()
        
        setNewsImageConstraints()
        setNewsTitleConstraints()
        setNewsDescriptionConstraints()
        setNewsPuslishDateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(news: ApiNews) {
        if let imageData = NSURL(string: news.urlToImage ?? "https://bhby.io.activecloud.com/8971091311/800x800/DETAIL_PICTURE.jpg") {
            newsImage.af.setImage(withURL: imageData as URL)
        }
        
        newsTitle.text = news.title
        newsDescription.text = news.description
        newsPublishDate.text = dateFormatter(date: news.publishedAt)
    }
    
    func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        let indexes = date.index(date.startIndex, offsetBy: 16)
        let formattedDate = String(date.prefix(upTo: indexes))

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        let convertedDate = dateFormatter.date(from: formattedDate)
        
        guard dateFormatter.date(from: formattedDate) != nil else {
            print("Error: Cannot convert date(\(formattedDate))")
            return "Date error"
        }
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let newDate = dateFormatter.string(from: convertedDate!)
        
        return newDate
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
    
    func configureNewsPublishDate() {
        newsPublishDate.numberOfLines = 1
        newsPublishDate.adjustsFontSizeToFitWidth = true
        newsPublishDate.textAlignment = .right
        newsPublishDate.font = UIFont.systemFont(ofSize: 12)
        newsPublishDate.textColor = .darkGray
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
    
    func setNewsPuslishDateConstraints() {
        newsPublishDate.translatesAutoresizingMaskIntoConstraints = false
        newsPublishDate.topAnchor.constraint(equalTo: newsDescription.bottomAnchor, constant: 10).isActive = true
        newsPublishDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
