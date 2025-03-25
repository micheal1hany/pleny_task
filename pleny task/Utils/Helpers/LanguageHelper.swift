//
//  LanguageHelper.swift

//
//  Created by Micheal Hany on 11/03/2024.
//

import Foundation

let LANGUAGE_KEY = "AppLanguage"

enum AppLanguage : String {
    case arabic = "ar_EG"
    case english = "en"
}

class Language: NSObject {
    
    override private init(){}
    
    static var currentLanguage : AppLanguage {
        
        var langStr = "en"
        
        if let lang = UserDefaults.standard.string(forKey: LANGUAGE_KEY) {
            langStr = lang
        } else {
            langStr = Locale.current.identifier
        }
        return langStr.contains("ar_EG") ? .arabic : .english
    }
    
    static func setCurrentLanguage(lang : AppLanguage) {
        UserDefaults.standard.set(lang.rawValue, forKey: LANGUAGE_KEY)
    }
    
    static func swichLanguage() {
        
        switch Language.currentLanguage {
        case .arabic:
            self.setCurrentLanguage(lang: .english)
            break
        case .english:
            self.setCurrentLanguage(lang: .arabic)
            break
        }
    }
    
    class var isRTL: Bool {
        return Language.currentLanguage == .arabic
    }
}
