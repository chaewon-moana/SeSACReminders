//
//  Color+Extension.swift
//  SeSACReminders
//
//  Created by cho on 2/15/24.
//

import UIKit

extension UIColor {
    static let primaryBackgroundColor = calColor(red: 28, green: 28, blue: 28, alpha: 1)
    static let secondBackgroundColor = calColor(red: 38, green: 38, blue: 39, alpha: 1)
    static let tableViewCellbackgroundColor = calColor(red: 99, green: 100, blue: 101, alpha: 1)
    
    static func calColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}


