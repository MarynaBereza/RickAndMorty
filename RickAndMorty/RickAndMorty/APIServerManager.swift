//
//  APIServerManager.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import Foundation

class APIServerManager {
    
    static func episodesRequest(array: [Int], completion: @escaping(_ episodes: [EpisodeModel]) -> ()) {

        let srtArray = array.map{String($0)}
        let episodeIDs = srtArray.joined(separator: ",")
        
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(episodeIDs)")
        
        guard let episodesURL = url else {
            return
        }

        
        let task = URLSession.shared.dataTask(with: episodesURL) {(data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let error = error {
                print(error)
            } else {
                
                let episodeModels = try! JSONDecoder().decode([EpisodeModel].self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(episodeModels)
                }
            }
        }
        task.resume()
    }
}
