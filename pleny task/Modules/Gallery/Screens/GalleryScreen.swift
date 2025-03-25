//
// 
//  GalleryScreen.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//
//

import SwiftUI

struct GalleryScreen: View {
    
    @ObservedObject private var vm = GalleryViewModel()
    
    var body: some View {
        Text("GalleryScreen")
            .toolbar {
                Button("ooook") {
                    print("oooooook")
                }
            }
    }
}

#Preview {
    GalleryScreen()
}
