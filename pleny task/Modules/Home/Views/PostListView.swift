//
//  PostListView.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI

struct PostListView:View{
    
    var posts:[PostUIModel]?
    
    @State private var expandedImage: ImageResource? = nil
    
    
    var body: some View{
        ZStack(alignment: .center) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 12) {
                    ForEach(posts ?? [],id: \.id){ post in
                        PostCell(postItem: post,expandedImage: $expandedImage)
                            .padding(.horizontal, 16)
                        
                        Divider()
                    }
                }
            }
            
            // Full-screen overlay when image is tapped
            if let image = expandedImage {
                FullScreenImageView(image: image, expandedImage: $expandedImage)
            }
        }
        
    }
}
