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
    
    init(character: Character) {
        self.characterName = character.name
        self.characterStatus = character.status
        
        guard let imageURL = URL(string: character.image) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.characterImage = image
                }
            }
        }
        .resume()
    }
}
