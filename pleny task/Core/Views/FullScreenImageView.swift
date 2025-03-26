//
//  FullScreenImageView.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI

struct FullScreenImageView: View {
    var image: ImageResource
    @Binding var expandedImage: ImageResource?

    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation(.spring()) {
                    expandedImage = nil
                }
            }
        
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.scale)
            .onTapGesture {
                withAnimation(.spring()) {
                    expandedImage = nil
                }
            }
    }
}
