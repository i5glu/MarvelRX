//
//  API.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class API {
    private let session = URLSession.shared

    var characters: Observable<CharacterDataWrapper> {
        let request = URLRequest(url: APIConstants.charactersURL)
        return session.rx.data(request: request).map {
            try JSONDecoder().decode(CharacterDataWrapper.self, from: $0)
        }
    }
}
