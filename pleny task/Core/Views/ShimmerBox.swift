//
//  ShimmerBox.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI

struct ShimmerBox: View {
    
    var width = 156.0
    var height = 156.0
    var cornerRadius = 8.0
    
    var isActive = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray)
            .customShimmer(isActive)
            .frame(maxWidth: width)
            .frame(height: height, alignment: .center)
    }
}
