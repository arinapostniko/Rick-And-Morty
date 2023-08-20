//
//  OriginView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import SwiftUI

struct OriginView: View {
    let location: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 80)
                .background(CustomColor.darkGrey)
                .cornerRadius(16)
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 64, height: 64)
                        .background(CustomColor.moreDarkGrey)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    Image("planet")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 28)
                }
                .frame(width: 64)
                .padding(.trailing, 8)
                VStack(alignment: .leading, spacing: 8) {
                    Text(location)
                        .font(.custom(Fonts.semiBold, size: 17))
                    Text("Planet")
                        .foregroundColor(CustomColor.green)
                        .font(.custom(Fonts.medium, size: 13))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        }
    }
}
