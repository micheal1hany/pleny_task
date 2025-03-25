//
//  AppHelper.swift

//
//  Created by Micheal Hany on 17/03/2024.
//

import SwiftUI

class AppHelper{
    private init(){}
    static func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    static func fireHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft){
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    static func fireHaptic(state:UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(state)
    }
}
