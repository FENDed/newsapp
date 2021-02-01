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
    static let sourceData = ["Not selected", "ABC News","ABC News (AU)","ANSA.it","Aftenposten","Al Jazeera English","Argaam","Ars Technica","Ary News","Associated Press","Australian Financial Review","Axios","BBC News","BBC Sport","Bild","Blasting News (BR)","Bleacher Report","Bloomberg","Breitbart News","Business Insider","Business Insider (UK)","Buzzfeed","CBC News","CBS News","CNN","CNN Spanish","Crypto Coins News","Der Tagesspiegel","Die Zeit","ESPN","ESPN Cric Info","El Mundo","Engadget","Entertainment Weekly","Financial Post","Focus","Football Italia","Fortune","FourFourTwo","Fox News","Fox Sports","Globo","Google News","Google News (Argentina)","Google News (Australia)","Google News (Brasil)","Google News (Canada)","Google News (France)","Google News (India)","Google News (Israel)","Google News (Italy)","Google News (Russia)","Google News (Saudi Arabia)","Google News (UK)","Gruenderszene","Göteborgs-Posten","Hacker News","Handelsblatt","IGN","Il Sole 24 Ore","Independent","InfoMoney","Infobae","L'equipe","La Gaceta","La Nacion","La Repubblica","Le Monde","Lenta","Les Echos","Libération","MSNBC","MTV News","MTV News (UK)","Marca","Mashable","Medical News Today","NBC News","NFL News","NHL News","NRK","National Geographic","National Review","New Scientist","New York Magazine","News24","News.com.au","Newsweek","Next Big Future","Politico","Polygon","RBC","RT","RTE","RTL Nieuws","Recode","Reddit /r/all","Reuters","SABQ","Spiegel Online","Svenska Dagbladet","T3n","TalkSport","TechCrunch","TechCrunch (CN)","TechRadar","The American Conservative","The Globe And Mail","The Hill","The Hindu","The Huffington Post","The Irish Times","The Jerusalem Post","The Lad Bible","The Next Web","The Sport Bible","The Times of India","The Verge","The Wall Street Journal","The Washington Post","The Washington Times","Time","USA Today","Vice News","Wired","Wired.de","Wirtschafts Woche","Xinhua Net","Ynet"]
    static let sourceDataId=["", "abc-news","abc-news-au","aftenposten","al-jazeera-english","ansa","argaam","ars-technica","ary-news","associated-press","australian-financial-review","axios","bbc-news","bbc-sport","bild","blasting-news-br","bleacher-report","bloomberg","breitbart-news","business-insider","business-insider-uk","buzzfeed","cbc-news","cbs-news","cnn","cnn-es","crypto-coins-news","der-tagesspiegel","die-zeit","el-mundo","engadget","entertainment-weekly","espn","espn-cric-info","financial-post","focus","football-italia","fortune","four-four-two","fox-news","fox-sports","globo","google-news","google-news-ar","google-news-au","google-news-br","google-news-ca","google-news-fr","google-news-in","google-news-is","google-news-it","google-news-ru","google-news-sa","google-news-uk","goteborgs-posten","gruenderszene","hacker-news","handelsblatt","ign","il-sole-24-ore","independent","infobae","info-money","la-gaceta","la-nacion","la-repubblica","le-monde","lenta","lequipe","les-echos","liberation","marca","mashable","medical-news-today","msnbc","mtv-news","mtv-news-uk","national-geographic","national-review","nbc-news","news24","new-scientist","news-com-au","newsweek","new-york-magazine","next-big-future","nfl-news","nhl-news","nrk","politico","polygon","rbc","recode","reddit-r-all","reuters","rt","rte","rtl-nieuws","sabq","spiegel-online","svenska-dagbladet","t3n","talksport","techcrunch","techcrunch-cn","techradar","the-american-conservative","the-globe-and-mail","the-hill","the-hindu","the-huffington-post","the-irish-times","the-jerusalem-post","the-lad-bible","the-next-web","the-sport-bible","the-times-of-india","the-verge","the-wall-street-journal","the-washington-post","the-washington-times","time","usa-today","vice-news","wired","wired-de","wirtschafts-woche","xinhua-net","ynet"]
    
}

struct Api {
    static let apiKey = "ad9c7dab67bf4d27ac4445536167d1f3" // another: 4a413821e5634116bfb101af0cd349c9 || MAIN: e3238b4597284853b256674408145838
    static var newsType = "top-headlines"
    static var category = "general"
    static var country = "ru"
    static var query = ""
    static var source = ""
    static var page = 1
}
