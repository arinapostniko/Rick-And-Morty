//
//  CacheManager.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 19.08.23.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
