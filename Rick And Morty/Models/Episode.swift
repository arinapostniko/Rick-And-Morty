//
//  Episode.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

struct Episode: Codable {
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}
