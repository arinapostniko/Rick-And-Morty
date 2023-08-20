//
//  MainScreenView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        NavigationView {
            MainScreenViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
