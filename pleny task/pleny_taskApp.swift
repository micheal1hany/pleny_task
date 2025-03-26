//
//  pleny_taskApp.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import SwiftUI

@main
struct pleny_taskApp: App {
    

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(\.locale, .init(identifier: "en_US"))
                .environment(\.layoutDirection, Language.isRTL ? .rightToLeft:.leftToRight)
                .colorScheme(.light)
        }
    }
}
