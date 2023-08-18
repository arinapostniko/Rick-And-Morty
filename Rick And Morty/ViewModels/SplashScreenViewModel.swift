//
//  SplashScreenViewModel.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import Foundation

class SplashScreenViewModel: ObservableObject {
    @Published var isCompleteLoading = false
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isCompleteLoading = true
        }
    }
}
