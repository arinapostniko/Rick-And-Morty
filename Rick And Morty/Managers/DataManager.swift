//
//  DataManager.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

enum DataError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Links: String  {
    case rickAndMortyAPI = "https://rickandmortyapi.com/api/character"
}

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping (Result<T, DataError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, DataError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        .resume()
    }
}
