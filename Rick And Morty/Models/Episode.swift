//
//  Episode.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

struct Episode: Codable, Hashable {
    var id: UUID
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        name = try container.decode(String.self, forKey: .name)
        airDate = try container.decode(String.self, forKey: .airDate)
        episode = try container.decode(String.self, forKey: .episode)
        characters = try container.decode([String].self, forKey: .characters)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func formatEpisode() -> String {
        if let seasonRange = episode.range(of: "S(\\d{2})", options: .regularExpression),
           let episodeRange = episode.range(of: "E(\\d{2})", options: .regularExpression) {
            
            let seasonNumber = String(Int(episode[seasonRange].dropFirst()) ?? 0)
            let episodeNumber = String(Int(episode[episodeRange].dropFirst()) ?? 0)
            
            return "Episode: \(episodeNumber), Season: \(seasonNumber)"
        } else {
            return episode
        }
    }
}
