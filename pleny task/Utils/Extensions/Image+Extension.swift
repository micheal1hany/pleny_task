//
//  Image+Extension.swift
//  sdk
//
//  Created by Micheal Hany on 28/12/2023.
//

import SwiftUI


extension Image{
    
    @ViewBuilder func imageSize(width:CGFloat?,height:CGFloat?,aspect:ContentMode = .fit)-> some View{
        self
            .resizable()
            .aspectRatio(contentMode: aspect)
            .frame(maxWidth: width)
            .frame(height: height)
    }
}
