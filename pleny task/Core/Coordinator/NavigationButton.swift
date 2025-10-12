//
//  NavigationButton.swift
//  pleny task
//
//  Created by Micheal Hany on 12/05/2025.
//


import SwiftUI

/// A Custom Button to work with the ``Coordinator``
struct NavigationButton<Content: View>: View {
    let destination: NavigationType
    @ViewBuilder var content: () -> Content
    @EnvironmentObject var coordinator: Coordinator

    init(
        destination: NavigationType,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = destination
        self.content = content
    }

    init(
        push destination: PushDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .push(destination)
        self.content = content
    }

    init(
        sheet destination: SheetDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .sheet(destination)
        self.content = content
    }

    init(
        fullScreen destination: FullScreenDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .fullScreenCover(destination)
        self.content = content
    }

    var body: some View {
        Button(action: { coordinator.navigate(to: destination) }) {
            content()
        }
    }
}
