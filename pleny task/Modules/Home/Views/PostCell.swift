//
//  PostCell.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI

struct PostCell: View {
    
//    var postItem:PostUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 2) {
                Image(.up1)
                    .imageSize(width: 40, height: 40,aspect: .fill)
                    .clipShape(Circle())
                
                
            }
        }
    }
}

#Preview {
    PostCell()
}
