//
//  MainScreenViewControllerRepresentable.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import Foundation

import UIKit
import SwiftUI

struct MainScreenViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainScreenViewController
    
    func makeUIViewController(context: Context) -> MainScreenViewController {
        let viewController = MainScreenViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MainScreenViewController, context: Context) {
        
    }
}
