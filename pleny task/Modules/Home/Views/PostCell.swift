//
//  PostCell.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI

struct PostCell: View {
    
    var postItem:PostUIModel
    
    @Binding var expandedImage: ImageResource? // Binding to handle which image is expanded

    
    let columns = Array(repeating: GridItem(.adaptive(minimum: 170),spacing: 8), count: 2)
    
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 8) {
                    if let userImage = postItem.userImage {
                        Image(userImage)
                            .imageSize(width: 40, height: 40, aspect: .fill)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    expandedImage = ImageResource(name: userImage, bundle: .main)
                                }
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(postItem.userName ?? "")
                            .textStyle(size: 17, color: AppColors.secondaryColor, weight: .semibold, alignment: .leading, textAlignment: .leading)
                        
                        Text("\(postItem.postDate ?? 0) days ago")
                            .textStyle(size: 13, color: AppColors.lightText, weight: .light, alignment: .leading, textAlignment: .leading)
                    }
                }
                
                Text(postItem.postBody ?? "")
                    .textStyle(size: 17, color: AppColors.secondaryColor, alignment: .leading, textAlignment: .leading)
                
                if (postItem.postImages?.count ?? 0 > 1){
                    LazyVGrid(columns: columns, alignment: .center,spacing: 8) {
                        ForEach(postItem.postImages ?? [],id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10, corners: .allCorners)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        expandedImage = ImageResource(name: image, bundle: .main)
                                    }
                                }
                                
                        }
                    }
                    .cornerRadius(10, corners: .allCorners)
                }else{
                    Image(postItem.postImages?.first ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10, corners: .allCorners)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                expandedImage = ImageResource(name: postItem.postImages?.first ?? "", bundle: .main)
                            }
                        }
                }
                
            }
    }
}

#Preview {
    PostCell(postItem: PostUIModel(res: Post.init(id: 1, title: "titleTest", body: "Craving something delicious? Try our new dish - a savory mix of roasted vegetables and quinoa, topped with a zesty garlic. Yum!",tags: [], reactions: Reactions(likes: 3, dislikes: 1), views: 3, userID: 20, postDate: 121,userName: "Micheal Hany",userImage: "up1",postImages: ["post_1","post_2","post_3"])), expandedImage: .constant(nil))
}
