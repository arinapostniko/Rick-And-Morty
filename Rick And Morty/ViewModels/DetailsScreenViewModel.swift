//
//  DetailsScreenViewModel.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 20.08.23.
//

import SwiftUI

class DetailsScreenViewModel: ObservableObject {
    @Published var characterImage: UIImage?
    @Published var characterName: String
    @Published var characterStatus: String
    @Published var species: String
    @Published var type: String
    @Published var gender: String
    @Published var location: String
    @Published var episodes: [Episode] = []
    
    init(character: Character) {
        self.characterName = character.name
        self.characterStatus = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
        self.location = character.location.name
        
        guard let imageURL = URL(string: character.image) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.characterImage = image
                }
            }
        }
        .resume()
        
        loadEpisodes(character.episode)
    }
    
    func loadEpisodes(_ episodeURLs: [String]) {
        for episodeURL in episodeURLs {
            if let url = URL(string: episodeURL) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data {
                        do {
                            let episode = try JSONDecoder().decode(Episode.self, from: data)
                            DispatchQueue.main.async {
                                self.episodes.append(episode)
                            }
                        } catch {
                            print("Error decoding episode:", error)
                        }
                    }
                }
                .resume()
            }
        }
    }
}
