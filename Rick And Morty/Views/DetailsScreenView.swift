//
//  DetailsScreenView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 19.08.23.
//

import SwiftUI

struct DetailsScreenView: View {
    let character: Character
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var viewModel: DetailsScreenViewModel
    
    init(character: Character) {
        self.character = character
        self._viewModel = ObservedObject(wrappedValue: DetailsScreenViewModel(character: character))
    }
    
    var body: some View {
        ZStack {
            CustomColor.darkBlue
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Spacer().frame(height: 16)
                    if let characterImage = viewModel.characterImage {
                        Image(uiImage: characterImage)
                            .resizable()
                            .frame(width: 148, height: 148)
                            .background(Color.gray)
                            .cornerRadius(16)
                            .padding(.horizontal, 113)
                    } else {
                        ProgressView()
                    }
                    Text(viewModel.characterName)
                        .font(.custom(Fonts.bold, size: 22))
                        .padding(.top, 24)
                    Text(viewModel.characterStatus)
                        .font(.custom(Fonts.medium, size: 16))
                        .foregroundColor(CustomColor.green)
                        .padding(.top, 8)
                    Text("Info")
                        .font(.custom(Fonts.semiBold, size: 17))
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    InfoView(species: viewModel.species, type: viewModel.type, gender: viewModel.gender)
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                    Text("Origin")
                        .font(.custom(Fonts.semiBold, size: 17))
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    OriginView(location: viewModel.location)
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image("chevron-left")
                .padding(.top, 16)
                .padding(.leading, 24)
        }
    }
}

//struct DetailsScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsScreenView()
//    }
//}
