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
    @State private var characterImage: UIImage?
    
    var body: some View {
        ZStack {
            CustomColor.darkBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 16)
                if let characterImage = characterImage {
                    Image(uiImage: characterImage)
                        .resizable()
                        .frame(width: 148, height: 148)
                        .background(Color.gray)
                        .cornerRadius(16)
                        .padding(.horizontal, 113)
                } else {
                    ProgressView()
                }
                Text(character.name)
                    .font(Font.custom(Fonts.bold, size: 22))
                    .padding(.top, 24)
                Text(character.status)
                    .font(Font.custom(Fonts.medium, size: 16))
                    .foregroundColor(CustomColor.green)
                    .padding(.top, 8)
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            loadImage()
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
    
    private func loadImage() {
        guard let imageURL = URL(string: character.image) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    characterImage = image
                }
            }
        }.resume()
    }
}

//struct DetailsScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsScreenView()
//    }
//}
