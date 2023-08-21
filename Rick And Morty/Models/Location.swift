//
//  Location.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 21.08.23.
//

import Foundation

struct Location: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
}
