//
//  SplashScreenView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var viewModel = SplashScreenViewModel()
    
    var body: some View {
        ZStack {
            CustomColor.darkBlue
                .edgesIgnoringSafeArea(.all)
            Image("dots")
            VStack(spacing: 36) {
                Image("label")
                Image("portal")
            }
            .offset(y: -120)
        }
        .fullScreenCover(isPresented: $viewModel.isCompleteLoading) {
            MainScreenView()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
