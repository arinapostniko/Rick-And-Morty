//
//  Info.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

struct Info: Codable {
    var count: Int
    var pages: Int
    var prev: String?
    var next: String
}
