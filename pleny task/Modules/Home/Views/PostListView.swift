//
//  PostListView.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI
import LoaderUI

import SwiftUI
import LoaderUI

struct PostListView: View {
    
    @State private var expandedImage: ImageResource? = nil
    @ObservedObject var vm: HomeViewModel
    @State private var scrollToTop: Bool = false
    @State private var showScrollButton: Bool = false
    @Binding var searchValue: String
    
    var body: some View {
        ZStack(alignment: .center) {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .center, spacing: 12) {
                        ForEach(Array(vm.posts?.enumerated() ?? [].enumerated()), id: \.element.id) { index ,post in
                            PostCell(postItem: post, expandedImage: $expandedImage)
                                .padding(.horizontal, 16)
                                .id(post.id) // Assign an ID to each post
                                .onAppear {
                                    if index >= 2{
                                        withAnimation(.easeIn) {
                                            showScrollButton = true
                                        }
                                    }else{
                                        withAnimation(.easeIn) {
                                            showScrollButton = false
                                        }
                                    }
                                    Task {
                                        await vm.loadNextPostsPage(currentItem: post, searchValue: searchValue)
                                    }
                                }
                            
                            Divider()
                        }
                        
                        if vm.paginationState == .nextPage {
                            CircleStrokeSpin()
                                .frame(width: 42, height: 42, alignment: .center)
                                .foregroundColor(Color(hex: AppColors.mainColor))
                                .padding(8)
                        }
                    }
                }
                .refreshable {
                    Task {
                        await vm.getPosts(skip: 0,searchValue: searchValue)
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .onChange(of: scrollToTop) { _ in
                    withAnimation {
                        proxy.scrollTo(vm.posts?.first?.id, anchor: .top)
                    }
                }
            }
            
            // Reset Scroll Button
            if showScrollButton{
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            scrollToTop.toggle()
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color(hex: AppColors.mainColor).clipShape(.circle))
                                .padding()
                        }
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
