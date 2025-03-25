//
//  Numbers+Extension.swift
//  ios mvvm project
//
//  Created by Micheal Hany on 03/12/2023.
//

import Foundation

extension Double {
    func formatPercentage() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self * 100)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        let formattedNumber = formatter.string(from: number)
        return formattedNumber ?? ""
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func localizedNumber()->String?{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))
    }
    func withCommas() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))
    }
}

extension Int {
    func withCommas() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))
    }
    
    func localizedNumber()->String?{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        return formatter.string(from: NSNumber(value: self))
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
