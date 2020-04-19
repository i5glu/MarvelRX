//
//  FaveCharactersStorage.swift
//  MarvelRX
//
//  Created by Илья Глущук on 19.04.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.

import Foundation

final class FaveCharactersStorage {
    static let shared = FaveCharactersStorage()

    private var characters: [Character] = []

    func save(character: Character) {
        characters.append(character)
    }
}
