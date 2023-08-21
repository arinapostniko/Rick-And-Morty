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
    
    private var backButton: some View {
        Button(action: {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Image("chevron-left")
        }
    }
    
    private func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return CustomColor.green
        case "dead":
            return .red
        default:
            return CustomColor.lightGrey
        }
    }
    
    init(character: Character) {
        self.character = character
        self._viewModel = ObservedObject(wrappedValue: DetailsScreenViewModel(character: character))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            CustomColor.darkBlue
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Spacer().frame(height: 64)
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
                        .foregroundColor(statusColor(for: viewModel.characterStatus))
                        .padding(.top, 8)
                    Text("Info")
                        .font(.custom(Fonts.semiBold, size: 17))
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    InfoView(species: viewModel.species, type: viewModel.type, gender: viewModel.gender)
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                    Text("Origin")
                        .font(.custom(Fonts.semiBold, size: 17))
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    OriginView(viewModel: viewModel, location: viewModel.locationType)
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                    Text("Episodes")
                        .font(.custom(Fonts.semiBold, size: 17))
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    EpisodesView(episodes: viewModel.episodes)
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                }
                .background(
                    GeometryReader { geo in
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                backButton
                                    .padding(.top, 8)
                                    .padding(.leading, 12)
                                    .frame(
                                        width: geo.size.width,
                                        height: geo.size.height,
                                        alignment: .topLeading
                                    )
                            }
                        }
                    }
                )
            }
            .navigationBarHidden(true)
        }
    }
}
