//
//  MenuOption.swift
//  newsapp
//
//  Created by User on 4.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case BookMarks
    case Settings
    
    var description: String {
        switch self {
        case .BookMarks: return "Bookmarks"
        case .Settings: return "Settings"
        }
    }
    
    var image: UIImage {
        switch self {
        case .BookMarks: return UIImage(named: "bookmark") ?? UIImage()
        case .Settings: return UIImage(named: "settings") ?? UIImage()
        }
    }
}
