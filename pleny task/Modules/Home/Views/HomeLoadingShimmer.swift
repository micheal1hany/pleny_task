//
//  HomeLoadingShimmer.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import SwiftUI

struct HomeLoadingShimmer: View {
    var body: some View {
        LazyVStack(alignment: .center, spacing: 12) {
            ForEach(1...10,id: \.self) { index in
                ShimmerBox(width: .infinity, height: 180, cornerRadius: 20)
                    .padding(.horizontal,16)
                Divider()
            }
        }
    }
}
