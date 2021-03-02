//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Maryna Bereza on 02.03.2021.
//  Copyright © 2021 Bereza Maryna. All rights reserved.
//

import Foundation

struct CharacterModel {
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    let id: Int
    let name: String
    let status: Status
    let image: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case image = "image"
        case created = "created"
    }
}

extension CharacterModel: Decodable {
    init(from decoder: Decoder) throws  {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        status = try values.decode(Status.self, forKey: .status)
        image = try values.decode(String.self, forKey: .image)
        created = try values.decode(String.self, forKey: .created)
    }
}
