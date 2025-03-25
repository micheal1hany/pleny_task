//
//  String+Date.swift
//  sdk
//
//  Created by Micheal Hany on 23/01/2024.
//

import Foundation

extension String{
    
    static func getCurrentDateTimeFormatted()->String{
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a zz"

            return dateFormatter.string(from: Date())
        }
    
    static func getCurrentLocalTime()->String{
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        dateFormatter.timeZone = TimeZone.current

        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
    
    func extractTime() -> String?{
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self){
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm:ss"
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
    func formatDateWithSlashes() -> String? {
        let dateFormatter = DateFormatter()
        
        guard let dateSegmant = self.components(separatedBy: "T").first else{return nil}
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateSegmant) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = Language.isRTL ? "yyyy/MM/dd" : "dd/MM/yyyy"
            outputFormatter.locale = Locale(identifier: Language.currentLanguage.rawValue)
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}


