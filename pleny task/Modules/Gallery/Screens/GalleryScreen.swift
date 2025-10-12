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
    
    @StateObject private var vm = GalleryViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack{
            NavigationButton(fullScreen: .login) {
                Text("Go to login fullscreen")
            }
            Text("GalleryScreen")
        }
            .toolbar {
                Button("Back") {
                    coordinator.pop()
                }
            }
    }
}

#Preview {
    GalleryScreen()
}
