//
//  UIKitWrapper.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import SwiftUI
import UIKit

struct UIKitWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainScreenViewController

    func makeUIViewController(context: Context) -> MainScreenViewController {
        return MainScreenViewController()
    }

    func updateUIViewController(_ uiViewController: MainScreenViewController, context: Context) {
        
    }
}
