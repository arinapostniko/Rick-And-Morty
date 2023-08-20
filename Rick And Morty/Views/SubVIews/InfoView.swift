//
//  InfoView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import SwiftUI

struct InfoView: View {
    let species: String
    let type: String
    let gender: String

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 124)
                .background(CustomColor.darkGrey)
                .cornerRadius(16)
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Species:")
                        .font(.custom(Fonts.medium, size: 16))
                        .foregroundColor(CustomColor.lightGrey)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    Text("Type:")
                        .font(.custom(Fonts.medium, size: 16))
                        .foregroundColor(CustomColor.lightGrey)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    Text("Gender:")
                        .font(.custom(Fonts.medium, size: 16))
                        .foregroundColor(CustomColor.lightGrey)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
                VStack(alignment: .trailing, spacing: 16) {
                    Text(species)
                        .font(.custom(Fonts.medium, size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                        .padding(.top, 16)
                    Text(type.isEmpty ? "None" : type)
                        .font(.custom(Fonts.medium, size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                    Text(gender)
                        .font(.custom(Fonts.medium, size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
            }
        }
    }
}
