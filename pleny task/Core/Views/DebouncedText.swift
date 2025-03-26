//
//  DebouncedText.swift
//  pleny task
//
//  Created by Micheal Hany on 26/03/2025.
//

import Combine
import Foundation

final class DebouncedText:ObservableObject{
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    
    init(dueTime: TimeInterval = 1) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: RunLoop.main)
            .assign(to: &$debouncedText)
    }
}
