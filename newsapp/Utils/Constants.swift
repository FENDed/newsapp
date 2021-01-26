//
//  Constants.swift
//  newsapp
//
//  Created by User on 8.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

struct Constants {
    static let categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    static let pickerData = ["Not selected", "United Arab Emirates", "Argentina", "Austria", "Australia", "Belgium", "Bulgaria", "Brazil", "Canada", "Switzerland", "China", "Colombia", "Cuba", "Czech Republic", "Germany", "Egypt", "France", "United Kingdom", "Greece", "Hong Kong", "Hungary", "Indonesia", "Ireland", "Israel", "India", "Italy", "Japan", "South Korea", "Italy", "Latvia", "Morocco", "Mexico", "Malaysia", "Nigeria", "Netherlands", "Norway", "New Zealand", "Philippines", "Poland", "Portugal", "Romania", "Serbia", "Russia", "Saudi Arabia", "Sweden", "Singapore", "Slovenia", "Slovakia", "Thailand", "Turkey", "Taiwan", "Ukraine", "United States", "Venezuela", "South Africa"]
}

struct Api {
    static let apiKey = "4a413821e5634116bfb101af0cd349c9" // another: 4a413821e5634116bfb101af0cd349c9 || MAIN: e3238b4597284853b256674408145838
    static var newsType = "top-headlines"
    static var category = "general"
    static var country = "ru"
    static var query = ""
}




