//
//  MainScreenView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import SwiftUI

struct MainScreenView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Fonts.bold, size: 28)!]
    }
    
    var body: some View {
        NavigationView {
            MainScreenViewControllerRepresentable()
                .navigationBarTitle("Characters", displayMode: .large)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
