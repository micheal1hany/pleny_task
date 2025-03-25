//
//  Text+Extension.swift
//  sdk
//
//  Created by Micheal Hany on 16/01/2024.
//

import SwiftUI

extension Text{
    
    @ViewBuilder func textFont(size:CGFloat,weight:Font.Weight? = .regular)-> Text{
        self.font(Font.system(size: size, weight: weight))
    }
}
