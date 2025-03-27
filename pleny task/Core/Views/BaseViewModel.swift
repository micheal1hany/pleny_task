//
//  BaseViewModel.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import Foundation

enum ViewState:Equatable {
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
             (.loading, .loading),
             (.empty, .empty),
             (.noInternet, .noInternet),
             (.success, .success):
            return true
        case let (.failed(lhsError), .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    case none
    case loading
    case empty
    case noInternet
    case failed(Error)
    case success
}

enum PaginationState:Equatable {
    static func == (lhs: PaginationState, rhs: PaginationState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
            (.nextPage, .nextPage),
            (.empty, .empty),
            (.lastPage, .lastPage):
            return true
        default:
            return false
        }
    }
    
    case none
    case nextPage
    case lastPage
    case empty
}

class BaseViewModel:ObservableObject {
    
    @MainActor @Published var state:ViewState = .none
    @MainActor @Published var paginationState:PaginationState = .none
    
}
