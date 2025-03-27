//
//  NoPostsView.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI

struct NoPostsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("No posts found")
                .textStyle(size: 32, color: AppColors.secondaryColor,weight: .bold, alignment: .center,textAlignment: .center)
            Spacer()
        }
    }
}
