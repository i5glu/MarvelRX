//
//  API.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit

final class API {
    private let session = URLSession.shared

    func characters(completion: (Result<CharacterDataWrapper, Error>) -> Void) {
        var request = URLRequest(url: APIConstants.charactersURL)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }

            let characters: CharacterDataWrapper = try! JSONDecoder().decode(CharacterDataWrapper.self, from: data)

            print(characters)
        }.resume()
    }
}
