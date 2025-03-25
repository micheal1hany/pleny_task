//
//  LazyView.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//


import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
