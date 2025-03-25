//
//  Color+Extention.swift
//  sdk
//
//  Created by Micheal Hany on 13/02/2024.
//

import Foundation
import UIKit

extension UIColor {
    static func colorFromHex(_ hex: String) -> UIColor? {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }
        
        guard colorString.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: colorString)
        var rgbValue: UInt64 = 0
        
        guard scanner.scanHexInt64(&rgbValue) else {
            return nil
        }
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


