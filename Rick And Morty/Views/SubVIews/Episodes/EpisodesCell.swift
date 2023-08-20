//
//  EpisodesCell.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import SwiftUI

struct EpisodesCell: View {
    let episode: Episode
    
    var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(height: 86)
              .background(CustomColor.darkGrey)
              .cornerRadius(16)
            VStack(alignment: .leading, spacing: 16) {
                Text(episode.name)
                    .font(.custom(Fonts.semiBold, size: 17))
                    .padding(.leading, 16)
                HStack {
                    Text(episode.formatEpisode())
                        .font(.custom(Fonts.medium, size: 12))
                        .foregroundColor(CustomColor.green)
                        .padding(.leading, 16)
                    Spacer()
                    Text(episode.airDate)
                        .font(.custom(Fonts.medium, size: 13))
                        .foregroundColor(CustomColor.lightGrey)
                        .padding(.trailing, 16)
                }
            }
        }
    }
}
