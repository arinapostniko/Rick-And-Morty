//
//  EpisodesView.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import SwiftUI

struct EpisodesView: View {
    var episodes: [Episode]
    
    var body: some View {
        VStack {
            if episodes.isEmpty {
                ProgressView()
            } else {
                ForEach(episodes, id: \.self) { episode in
                    EpisodesCell(episode: episode)
                        .padding(.top, 8)
                }
            }
        }
    }
}
