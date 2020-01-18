//
//  Character.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int
    let copyright: String?
    let data: CharacterDataContainer?
    let etag: String?
}

struct CharacterDataContainer: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let description: String?
    let resourceURI: String?
    let thumbnail: APIImage
}

struct APIImage: Decodable {
    let path: String
    let fileExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
