//
//  ZoomTransitionModifier.swift
//  CoordinatorDemo
//
//  Created by Micheal Hany on 25/12/2024.
//

import SwiftUI

struct ZoomTransitionModifier: ViewModifier {
    var isAnimating: Binding<Bool>
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating.wrappedValue ? 0.9 : 1,anchor: .center)
            .opacity(isAnimating.wrappedValue ? 0.5:1)
            .transition(.scale(scale: 0,anchor: .center).combined(with: .opacity))
            
    }
}
