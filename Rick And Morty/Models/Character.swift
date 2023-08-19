//
//  Character.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Origin
    var image: String
    var episode: [String]
    var url: String
    var created: String
}
